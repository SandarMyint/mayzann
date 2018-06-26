defmodule MayzannWeb.AuthView do
    use MayzannWeb, :view
    alias MayzannWeb.AuthView

    def render("show.json", %{user: user}) do
        %{
            status: "200",
            message: "SUCCESS",
            data: user_json(user)
        }
    end

    def user_json(user) do
        %{
            username: user.username,
            profile: "http://github.api.com/user=2313213?profile"
        }
    end

end