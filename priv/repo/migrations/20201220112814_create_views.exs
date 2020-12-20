defmodule Tex.Repo.Migrations.CreateViews do
  use Ecto.Migration

  def change do
    create table(:views) do
      add :post_id, references(:posts, on_delete: :delete_all)
      add :user_id, references(:users, on_delete: :delete_all)

      timestamps()
    end

    create index(:views, [:post_id])
    create index(:views, [:user_id])
  end
end
