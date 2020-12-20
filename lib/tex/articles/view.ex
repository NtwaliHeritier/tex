defmodule Tex.Articles.View do
  use Ecto.Schema
  import Ecto.Changeset
  alias Tex.Accounts.User
  alias Tex.Articles.Post

  schema "views" do
    belongs_to :user, User
    belongs_to :post, Post

    timestamps()
  end

  @doc false
  def changeset(view, attrs) do
    view
    |> cast(attrs, [])
    |> validate_required([])
  end
end
