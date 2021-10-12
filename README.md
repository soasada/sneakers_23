# Sneakers23

1. Install application:

`mix deps.get && mix ecto.setup`

## Clean docker

`docker stop sneakers_23_db_1 && docker rm sneakers_23_db_1`

## Reset database and add clean data

`mix ecto.reset && mix run -e "Sneakers23Mock.Seeds.seed!()"`

## Release one product

`Sneakers23.Inventory.mark_product_released!(1)`
