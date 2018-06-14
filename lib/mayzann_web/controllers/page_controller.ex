defmodule MayzannWeb.PageController do
  use MayzannWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
