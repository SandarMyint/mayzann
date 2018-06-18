defmodule MayzannWeb.PostController do
    use MayzannWeb, :controller

    alias Mayzann.Post
    alias Mayzann.Repo
    alias Mayzann.User
    
    # plug Discuss.Plugs.RequireAuth when action in [:new, :create, :edit, :update, :delete]
#   plug :check_topic_owner when action in [:update, :edit, :delete]

    # Show All Posts 
    def index(conn, _params) do
        posts = Repo.all(Post)
        render(conn, "index.json", posts: posts)
    end

    #Show Post Details By ID
    def show(conn, %{"id" => post_id}) do
        post = Repo.get!(Post, post_id)
        render(conn, "showone.json" , post: post)
    end

    #Go To Create Page 
    def new(conn, _params) do
        # IO.inspect conn
        changeset = Post.changeset(%Post{} , %{})
        render(conn, "new.html", changeset: changeset)
    end

    def create(conn, %{"post" => post}) do
        IO.inspect(conn.assigns.user)
        changeset = conn.assigns.user
        |> Ecto.build_assoc(:posts)
        |> Post.changeset(post)
        text conn, "hello world"
        
    end

    

  end
  