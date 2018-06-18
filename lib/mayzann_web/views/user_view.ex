defmodule MayzannWeb.UserView do
    use MayzannWeb, :view

    def render("show.json", %{user: user}) do
        %{
            user: user_json(user)
        }
    end

    def user_json(user) do
        %{
            id: user.id,
            username: user.username,
        }
    end


end