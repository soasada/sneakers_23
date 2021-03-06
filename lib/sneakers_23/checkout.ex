defmodule Sneakers23.Checkout do
  alias Sneakers23.Checkout.ShoppingCart

  @cart_id_length 64

  defdelegate add_item_to_cart(cart, item), to: ShoppingCart, as: :add_item
  defdelegate remove_item_from_cart(cart, item), to: ShoppingCart, as: :remove_item
  defdelegate cart_item_ids(cart), to: ShoppingCart, as: :item_ids
  defdelegate export_cart(cart), to: ShoppingCart, as: :serialize

  def restore_cart(nil), do: ShoppingCart.new()

  def restore_cart(serialized) do
    case ShoppingCart.deserialize(serialized) do
      {:ok, cart} -> cart
      {:error, _} -> restore_cart(nil)
    end
  end

  def generate_cart_id() do
    :crypto.strong_rand_bytes(@cart_id_length)
    |> Base.encode64()
    |> binary_part(0, @cart_id_length)
  end
end
