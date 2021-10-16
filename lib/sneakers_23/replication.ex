defmodule Sneakers23.Replication do
  alias Sneakers23.Replication.Server

  defdelegate child_spec(opts), to: Server

  def mark_product_released!(product_id) do
    broadcast!({:mark_product_released!, product_id})
  end

  def item_sold!(item_id) do
    broadcast!({:item_sold!, item_id})
  end

  # we use broadcast_from! to send a message to all processes except the local process,
  # only remote nodes will receive the replication events.
  defp broadcast!(data) do
    Phoenix.PubSub.broadcast_from!(
      Sneakers23.PubSub,
      server_pid(),
      "inventory_replication",
      data
    )
  end

  defp server_pid(), do: Process.whereis(Server)
end
