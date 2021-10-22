defmodule Sneakers23Web.ShoppingCartChannel do
  use Sneakers23Web, :channel
  import Sneakers23Web.CartView, only: [cart_to_map: 1]

  @impl true
  def join("cart:" <> id, payload, socket) when byte_size(id) == 64 do
    cart = get_cart(payload)
    new_socket = assign(socket, :cart, cart)
    send(self(), :send_cart)
    {:ok, new_socket}
  end

  @impl true
  def handle_info(:send_cart, socket = %{assigns: %{cart: cart}}) do
    push(socket, "cart", cart_to_map(cart))
    {:noreply, socket}
  end

  defp get_cart(params) do
    params
    |> Map.get("serialized", nil)
    |> Sneakers23.Checkout.restore_cart()
  end
end
