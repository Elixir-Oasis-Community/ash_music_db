defmodule AshMusicDb.AlbumGenre do
  use Ash.Resource, domain: AshMusicDb, data_layer: AshPostgres.DataLayer

  postgres do
    table "album_genre"
    repo(AshMusicDb.Repo)
  end

  actions do
    defaults [:read, :create, :destroy]
  end

  relationships do
    belongs_to :album, AshMusicDb.Album do
      primary_key? true
      allow_nil? false
    end

    belongs_to :genre, AshMusicDb.Genre do
      primary_key? true
      allow_nil? false
    end
  end

  attributes do
    create_timestamp :created_at
    update_timestamp :updated_at
  end
end
