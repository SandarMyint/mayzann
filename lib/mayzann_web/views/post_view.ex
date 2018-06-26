defmodule MayzannWeb.PostView do
    use MayzannWeb, :view
    alias MayzannWeb.PostView

    def render("index.json", %{posts: posts}) do
        %{data: render_many(posts, PostView, "posts.json")}
    end

    def render("posts.json", %{post: post}) do
        %{id: post.id,
          title: post.title,
          description: post.description
          user_id: post.user_id
        }
    end

    def render("detail.json", %{post: post}) do
       %{data: render_one(post, PostView, "post.json")} 
    end

    def render("post.json", %{post: post}) do
        %{
            id: post.id,
            title: post.title,
            description: post.description
            user_id: user_id
        }
    end
end