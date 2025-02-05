defmodule AshMusicDb.Repo.Migrations.AddBandStatus do
  @moduledoc """
  Updates resources based on their most recent snapshots.

  This file was autogenerated with `mix ash_postgres.generate_migrations`
  """

  use Ecto.Migration

  def up do
    alter table(:bands) do
      add :status, :text
    end
  end

  def down do
    alter table(:bands) do
      remove :status
    end
  end
end
