defmodule MayzannWeb.PostView do
    use MayzannWeb, :view
    alias MayzannWeb.PostView

    def render("index.json", %{posts: posts}) do
        %{data: render_many(posts, PostView, "posts.json")}
    end

    def render("posts.json", %{post: post}) do
        %{
            id: post.id,
            title: post.title,
            description: post.description
        }
    end

    def render("detail.json", %{post: post}) do
       %{data: render_one(post, PostView, "post.json")} 
    end

    def render("post.json", %{post: post}) do
        %{
            id: post.id,
            title: post.title,
            description: post.description,
            user: user_json(post.user)
        }
    end

    def user_json(user) do
        %{
            username: user.username,
            email: user.email,
            avatar_url: user.avatar_url,
            provider: user.provider
        }
    end
end