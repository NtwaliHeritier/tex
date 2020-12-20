defmodule Tex.Articles.Post do
  use Ecto.Schema
  import Ecto.Changeset
  use Arc.Ecto.Schema
  alias Tex.Accounts.User
  alias Tex.Articles.Like

  schema "posts" do
    field :content, :string
    field :image, Tex.ImageUploader.Type
    field :title, :string
    belongs_to :user, User
    has_many :likes, Like

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:title, :content, :image])
    |> cast_attachments(attrs, [:image])
    |> validate_required([:title, :content, :image])
  end
end
