defmodule MayzannWeb.FallbackController do
    use MayzannWeb, :controller

    alias MayzannWeb.ErrorView

    def call(conn, nil) do
        conn
        |> render(ErrorView, "error.json", message: "FallbackController")
    end

end
