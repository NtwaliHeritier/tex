defmodule Tex.Repo.Migrations.CreateInvitations do
  use Ecto.Migration

  def change do
    create table(:invitations) do
      add :invitee_id, :integer
      add :invitor_id, :integer
      add :status, :boolean, default: false, null: false

      timestamps()
    end

  end
end
