defmodule Sneakers23Web.ProductSocket do
  use Phoenix.Socket

  channel "product:*", Sneakers23Web.ProductChannel

  @impl true
  def connect(_params, socket, _connect_info) do
    {:ok, socket}
  end

  @impl true
  def id(_socket), do: nil
end
