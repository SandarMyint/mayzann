defmodule MayzannWeb.UserController do
    use MayzannWeb, :controller

    alias Mayzann.Accounts
    action_fallback MayzannWeb.FallbackController

    def show(conn, %{"id" => user_id}) do
        user = Accounts.get_user(user_id)
        # text conn, "ok nice"
        if user do
            render(conn, "show.json", user: user)
        end
    end


    
end