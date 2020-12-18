defmodule Tex.Repo.Migrations.CreateAccounts do
  use Ecto.Migration

  def change do
    create table(:accounts) do
      add :first_name, :string
      add :last_name, :string
      add :gender, :string
      add :phone, :string
      add :country, :string
      add :city, :string
      add :username, :string
      add :image_path, :string
      add :user_id, references(:users, on_delete: :delete_all)

      timestamps()
    end

    create index(:accounts, [:user_id])
  end
end
