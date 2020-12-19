defmodule Tex.Accounts.Account do
  use Ecto.Schema
  use Arc.Ecto.Schema
  import Ecto.Changeset
  alias Tex.Accounts.User

  schema "accounts" do
    field :city, :string
    field :country, :string
    field :first_name, :string
    field :gender, :string
    field :image_path, Tex.ImageUploader.Type
    field :last_name, :string
    field :phone, :string
    field :username, :string
    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(account, attrs) do
    account
    |> cast(attrs, [:first_name, :last_name, :gender, :phone, :country, :city, :username, :image_path])
    |> cast_attachments(attrs, [:image_path])
    |> validate_required([:first_name, :last_name, :gender, :phone, :country, :city, :username, :image_path])
  end
end
