defmodule Tex.Articles.Like do
  use Ecto.Schema
  import Ecto.Changeset
  alias Tex.Accounts.User
  alias Tex.Articles.Post

  schema "likes" do
    belongs_to :user, User
    belongs_to :post, Post

    timestamps()
  end

  @doc false
  def changeset(like, attrs) do
    like
    |> cast(attrs, [])
    |> validate_required([])
  end
end
