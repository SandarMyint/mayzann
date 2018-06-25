defmodule MayzannWeb.AuthController do
    use MayzannWeb, :controller
    plug Ueberauth

    alias Mayzann.User
    alias Mayzann.Repo
    
    def index(conn, _params) do
        text conn, "auth controller index"
    end

    def callback(%{assigns: %{ueberauth_auth: auth}} = conn, params) do
        IO.inspect conn
        user_params = %{username: auth.info.nickname, token: auth.credentials.token, email: auth.info.email, provider: "github"}
        changeset = User.changeset(%User{}, user_params)
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
        case Repo.get_by(User, email: changeset.changes.email) do
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

    def gg(conn,  _params) do

        # IO.inspect params
        HTTPoison.start

        body = Poison.encode!(%{
            "client_id": "d625961b69225e5d76f2",
            "client_secret": "a44902336f737824fcebff40c862a6bffcf0ff63",
            "code": "03e112c939756ad82262",
          })

        # body = [client_id: "d625961b69225e5d76f2",client_secret: "a44902336f737824fcebff40c862a6bffcf0ff63",code: "51901febea16219ec30a"]
        headers = [{"Content-type", "application/json"}]
        url = "https://github.com/login/oauth/access_token"
        {:ok, response} = HTTPoison.post(url, body, headers, [])

        # IO.inspect response

        case response.body =~ "access_token" do
            true -> getUser(response.body)
            false -> getUser(response.body)
        end

        text conn, "gg"
    end

    def getUser(body) do
        url = "https://api.github.com/user?access_token=db41c3e486a5dfd9717af4f34882c747441420e2&scope=user%3Aemail&token_type=bearer"
        IO.puts "URL to request::"
        IO.inspect url
        {:ok, response} = HTTPoison.get(url)
        IO.puts "GG RESPONSE BODY::::"
        # IO.inspect response.body
        test = Poison.decode(~s(#{response.body}))
        IO.inspect test

        {:ok, %{"login" => login, "email" => email}} = test
        IO.puts login
        IO.puts email
        user_params = %{username: login, email: email, provider: "github"}
        changeset = User.changeset(%User{}, user_params)
        insert_or_update_user(changeset)
    end

end
