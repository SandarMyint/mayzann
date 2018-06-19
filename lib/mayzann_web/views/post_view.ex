defmodule MayzannWeb.PostView do
    use MayzannWeb, :view
    alias MayzannWeb.PostView

    def render("index.json", %{posts: posts}) do
        %{data: render_many(posts, PostView, "post.json")}
    end

    # def render("show.json", %{post: post}) do
    #     %{data: render_one(post, PostView, "post.json")}
    # end

    def render("post.json", %{post: post}) do
        %{id: post.id,
          title: post.title,
          description: post.description
        }
    end

    def render("detail.json", %{post: post}) do
       %{data: render_one(post, PostView, "postdetail.json")} 
    end

    def render("postdetail.json", %{post: post}) do
        %{
            id: post.id,
            title: post.title,
            description: post.description
        }
    end
end