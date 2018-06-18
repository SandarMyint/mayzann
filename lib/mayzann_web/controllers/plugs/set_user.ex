defmodule MayzannWeb.Plugs.SetUser do
    import Plug.Conn
    import Phoenix.Controller
  
    alias Mayzann.Repo
    alias Mayzann.User
    # alias Discuss.Router.Helpers
  
    def init(_params) do
    end
  
    def call(conn, _params) do
      user_id = get_session(conn, :user_id)
      cond do
          user = user_id && Repo.get(User, user_id) ->
            assign(conn, :user, user)
            # conn.assigns.user => user struct
          true ->
            assign(conn, :user, nil)
      end
    end
  end
  