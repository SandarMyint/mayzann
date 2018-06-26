defmodule MayzannWeb.PostController do
    use MayzannWeb, :controller

    alias Mayzann.Post
    alias Mayzann.Repo
    alias Mayzann.User

    alias MayzannWeb.PageView
    
    # plug Discuss.Plugs.RequireAuth when action in [:new, :create, :edit, :update, :delete]
#   plug :check_topic_owner when action in [:update, :edit, :delete]

    # Show All Posts 
    def index(conn, _params) do
        posts = Repo.all(Post)
        render(conn, "index.json", posts: posts)
    end

    #Show Post Details By ID
    def detail(conn, %{"id" => post_id}) do
        post = Repo.get!(Post, post_id)
        render(conn, "detail.json" , post: post)
    end

    #Go To Create Page 
    # def new(conn, _params) do
    #     changeset = Post.changeset(%Post{} , %{})
    #     render(conn, "new.html", changeset: changeset)
    # end

    # def create(conn, %{"post" => post}) do
    #     IO.inspect(conn.assigns.user)
    #     changeset = conn.assigns.user
    #     |> Ecto.build_assoc(:posts)
    #     |> Post.changeset(post)
        
    #     case Repo.insert(changeset) do
    #         {:ok, post} ->
    #             conn
    #             |> put_flash(:info, "Success Post !")
    #             |> redirect(to: page_path(conn, :index))
    #     end
    # end

    def create(conn, post_params) do
        IO.inspect(post_params)

        changeset = Post.changeset(%Post{}, post_params)
        case Repo.insert(changeset) do
            {:ok, _post} ->
                posts = Repo.all(Post)
                render conn, "index.json", posts: posts
        end
    end

    # def edit(conn, %{"id" => id}) do
    #     post = Reop.get(Post, id)
    #     changeset = Post.changeset(post)
    #     #Enum.each(list, fn(item) -> IO.puts(item) end)
    #     render conn, "edit.html", changeset: changeset, post: post
    # end

    def update(conn, post_params) do
        %{"id" => post_id} = post_params

        post = Repo.get(Post, post_id)
        changeset = Post.changeset(post, post_params)

        case Repo.update(changeset) do
            {:ok,_post} ->
                post = Repo.get(Post, post_id)
                render conn, "detail.json", post: post
        end
    end

    def delete(conn, %{"id" => post_id}) do
        post = Repo.get(Post, post_id)
        case Repo.delete(post) do
            {:ok, _post} ->
                posts = Repo.all(Post)
                render conn, "index.json", posts: posts
        end
    end
  end
  