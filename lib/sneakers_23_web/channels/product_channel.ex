defmodule Sneakers23Web.ProductChannel do
  use Sneakers23Web, :channel

  def notify_product_released(product = %{id: id}) do
    size_html = Phoenix.View.render_to_string(Sneakers23Web.ProductView, "_sizes.html", product: product)
    Sneakers23Web.Endpoint.broadcast!("product:#{id}", "released", %{size_html: size_html})
  end

  @impl true
  def join("product:" <> _sku, _payload, socket) do
    {:ok, socket}
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  @impl true
  def handle_in("ping", payload, socket) do
    {:reply, {:ok, payload}, socket}
  end

  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (product:lobby).
  @impl true
  def handle_in("shout", payload, socket) do
    broadcast socket, "shout", payload
    {:noreply, socket}
  end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end
end
