# Sneakers23

1. Install application:

`mix deps.get && mix ecto.setup`

## Clean docker

`docker stop sneakers_23_db_1 && docker rm sneakers_23_db_1`

## Reset database and add clean data

`mix ecto.reset && mix run -e "Sneakers23Mock.Seeds.seed!()"`

## Release one product

`Sneakers23.Inventory.mark_product_released!(1)`

## Demo for replication

1. Re-seed database:

`mix ecto.reset && mix run -e "Sneakers23Mock.Seeds.seed!()"`

2. In one shell:

`iex --name app@127.0.0.1 -S mix phx.server`

3. In another shell:

`iex --name back@127.0.0.1 -S mix`

`Node.connect(:"app@127.0.0.1")`

`Sneakers23.Inventory.mark_product_released!(1)`

`Sneakers23.Inventory.mark_product_released!(2)`

`Sneakers23Mock.InventoryReducer.sell_random_until_gone!()`
