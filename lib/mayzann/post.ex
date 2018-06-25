defmodule Mayzann.Post do
  use Ecto.Schema
  import Ecto.Changeset

  schema "posts" do
    field :description, :string
    field :title, :string
    belongs_to :user, Mayzann.User

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:title, :description, :user_id])
    |> validate_required([:title, :description, :user_id])
  end
end
