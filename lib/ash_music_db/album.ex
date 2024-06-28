defmodule AshMusicDb.Album do
  use Ash.Resource, domain: AshMusicDb, data_layer: AshPostgres.DataLayer

  postgres do
    table "albums"
    repo(AshMusicDb.Repo)
  end

  actions do
    defaults [:update, :destroy]

    read :read do
      # Primary actions are a way to inform the framework which actions should be used in certain “automated” circumstances,
      # or in cases where an action has not been specified. https://ash-hq.org/docs/guides/ash/latest/topics/actions#primary-actions
      primary? true
      prepare build(load: [:category, :genres])
    end

    create :create do
      accept [:title]
      primary? true

      argument :genres, {:array, :map}
      argument :add_genre, :map, do: allow_nil?(true)

      change manage_relationship(:genres, type: :append_and_remove, on_no_match: :create)
      change manage_relationship(:add_genre, :genres, type: :create, value_is_key: :name)
    end
  end

  attributes do
    uuid_primary_key :id

    attribute :title, :string, do: allow_nil?(false)

    create_timestamp :created_at
    update_timestamp :updated_at
  end

  relationships do
    belongs_to :artist, AshMusicDb.Artist do
      attribute_writable? true
    end

    has_many :tracks, AshMusicDb.Track

    many_to_many :genres, AshMusicDb.Genre do
      through AshMusicDb.AlbumGenre
      source_attribute_on_join_resource :album_id
      destination_attribute_on_join_resource :genre_id
    end
  end
end
