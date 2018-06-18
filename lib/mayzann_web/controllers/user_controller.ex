defmodule MayzannWeb.UserController do
    use MayzannWeb, :controller

    def show(conn, %{"id" => user_id}) do
        conn
        |> text(user_id)
    end

    
    
end