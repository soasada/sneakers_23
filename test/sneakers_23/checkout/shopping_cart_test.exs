defmodule Sneakers23.Checkout.ShoppingCartTest do
  use ExUnit.Case
  alias Sneakers23.Checkout.ShoppingCart

  test "add item" do
    {:ok, %{items: [head | _]}} = ShoppingCart.new()
                                  |> ShoppingCart.add_item(1)
    assert 1 == head
  end

  test "add duplicated item fail" do
    {:ok, cart} = ShoppingCart.new()
                  |> ShoppingCart.add_item(1)
    {:error, :duplicate_item} = cart
                                |> ShoppingCart.add_item(1)
  end

  test "add non integer item" do
    assert_raise FunctionClauseError, fn ->
      ShoppingCart.new()
      |> ShoppingCart.add_item("TEST")
    end
  end

  test "remove item" do
    {:ok, cart} = ShoppingCart.new()
                  |> ShoppingCart.add_item(1)
    {:ok, empty_cart} = cart
                        |> ShoppingCart.remove_item(1)
    assert length(empty_cart.items) == 0
  end

  test "remove unknown item fails" do
    {:error, :not_found} = ShoppingCart.new()
                           |> ShoppingCart.remove_item(1)
  end

  test "list items" do
    {:ok, cart} = ShoppingCart.new()
                  |> ShoppingCart.add_item(1)
    assert [1] == cart
                  |> ShoppingCart.item_ids()
  end
end
