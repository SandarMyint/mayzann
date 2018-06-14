defmodule MayzannWeb.AuthController do
    use MayzannWeb, :controller
    plug Ueberauth

    alias Mayzann.AddUsers
    alias Mayzann.Repo
    
    def index(conn, _params) do
        text conn, "auth controller index"
    end

    def callback(%{assigns: %{ueberauth_auth: auth}} = conn, params) do
        user_params = %{username: auth.info.nickname, token: auth.credentials.token, email: auth.info.email, provider: "github"}
        # IO.puts(user_params)
        # IO.inspect(user_params)
        changeset = AddUsers.changeset(%AddUsers{}, user_params)
        signin(conn, changeset)
    end

    defp signin(conn, changeset) do
        case insert_or_update_user(changeset) do
          {:ok, user} ->
            conn
            |> put_flash(:info, "Welcome back!")
            |> put_session(:user_id, user.id)
            |> redirect(to: page_path(conn, :index))
          {:error, _reason} ->
            conn
            |> put_flash(:error, "Error signing in")
            |> redirect(to: page_path(conn, :index))
    
        end
    end
    
    def insert_or_update_user(changeset) do
        case Repo.get_by(AddUsers, email: changeset.changes.email) do
          nil ->
            Repo.insert(changeset)
          user ->
            {:ok, user}
        end
    end

    def signout(conn, _params) do
        conn
        |> configure_session(drop: true)
        |> redirect(to: page_path(conn, :index))
    end
end
