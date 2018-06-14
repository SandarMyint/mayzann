defmodule MayzannWeb.PostController do
    use MayzannWeb, :controller

    alias Mayzann.Post
    alias Mayzann.Repo

    def index(conn, _params) do
        posts = Repo.all(Post)
        render(conn, "index.json", posts: posts)
    end

  end
  