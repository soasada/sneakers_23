defmodule Sneakers23.Replication.Server do
  use GenServer
  alias Sneakers23.Inventory

  def start_link(opts) do
    GenServer.start_link(__MODULE__, opts, name: __MODULE__)
  end

  # SERVER callbacks

  # Any message sent to "inventory_replication" topic will be received by the server as "regular" messages.
  @impl true
  def init(_opts) do
    Phoenix.PubSub.subscribe(Sneakers23.PubSub, "inventory_replication")
    {:ok, nil}
  end

  # Each message type will need to be handled by using a handle_info callback.
  @impl true
  def handle_info({:mark_product_released!, product_id}, state) do
    Inventory.mark_product_released!(product_id, being_replicated?: true)
    {:noreply, state}
  end

  @impl true
  def handle_info({:item_sold!, id}, state) do
    Inventory.item_sold!(id, being_replicated?: true)
    {:noreply, state}
  end
end
