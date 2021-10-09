defmodule Sneakers23Web.PageController do
  use Sneakers23Web, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
