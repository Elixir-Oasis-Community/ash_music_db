defmodule AshMusicDb.Repo.Migrations.CreateAlbumGenre do
  @moduledoc """
  Updates resources based on their most recent snapshots.

  This file was autogenerated with `mix ash_postgres.generate_migrations`
  """

  use Ecto.Migration

  def up do
    create table(:album_genre, primary_key: false) do
      add :created_at, :utc_datetime_usec,
        null: false,
        default: fragment("(now() AT TIME ZONE 'utc')")

      add :updated_at, :utc_datetime_usec,
        null: false,
        default: fragment("(now() AT TIME ZONE 'utc')")

      add :album_id,
          references(:albums,
            column: :id,
            name: "album_genre_album_id_fkey",
            type: :uuid,
            prefix: "public"
          ),
          primary_key: true,
          null: false

      add :genre_id,
          references(:genres,
            column: :id,
            name: "album_genre_genre_id_fkey",
            type: :uuid,
            prefix: "public"
          ),
          primary_key: true,
          null: false
    end
  end

  def down do
    drop constraint(:album_genre, "album_genre_album_id_fkey")

    drop constraint(:album_genre, "album_genre_genre_id_fkey")

    drop table(:album_genre)
  end
end
