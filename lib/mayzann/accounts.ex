defmodule Mayzann.Accounts do
    
    import Ecto.Changeset
    import Ecto.Query

    alias Mayzann.{User, Repo, Post}

    def get_user(user_id) do
        Repo.get(User, user_id)
    end

    # getting users
    def get_post(user_id) do
        Repo.get(Post, user_id)
    end

    # testing if posts can be obtained by users
    def get_post_by_user(user_id) do
        # Repo.get_by(Post, user_id: user_id)
        from(p in Post, where: p.user_id == ^user_id) |> Repo.all
    end

end