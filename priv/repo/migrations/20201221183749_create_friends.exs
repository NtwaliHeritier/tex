defmodule Tex.Repo.Migrations.CreateFriends do
  use Ecto.Migration

  def change do
    create table(:friends) do
      add :follower_id, :integer
      add :followee_id, :integer

      timestamps()
    end

  end
end
