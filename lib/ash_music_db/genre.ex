defmodule AshMusicDb.Genre do
  use Ash.Resource, domain: AshMusicDb, data_layer: AshPostgres.DataLayer

  postgres do
    table "genres"
    repo(AshMusicDb.Repo)
  end

  actions do
    defaults [:read, :create, :update, :destroy]
  end

  attributes do
    uuid_primary_key :id

    attribute :name, :string, do: allow_nil?(false)
    attribute :wiki_tag, :string

    create_timestamp :created_at
    update_timestamp :updated_at
  end

  relationships do
    many_to_many :albums, AshMusicDb.Album do
      through AshMusicDb.AlbumGenre
      source_attribute_on_join_resource :genre_id
      destination_attribute_on_join_resource :album_id
    end
  end
end
