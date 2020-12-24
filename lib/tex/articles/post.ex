defmodule Tex.Articles.Post do
  use Ecto.Schema
  import Ecto.Changeset
  alias Tex.Accounts.User
  alias Tex.Articles.{Like, View, Comment}

  schema "posts" do
    field :content, :string
    field :image, :string
    field :title, :string
    belongs_to :user, User
    has_many :likes, Like
    has_many :views, View
    has_many :comments, Comment

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:title, :content, :image])
    |> validate_required([:title, :content, :image])
  end
end
