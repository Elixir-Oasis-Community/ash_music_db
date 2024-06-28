defmodule AshMusicDb.Track do
  use Ash.Resource, domain: AshMusicDb, data_layer: AshPostgres.DataLayer

  postgres do
    table "tracks"
    repo(AshMusicDb.Repo)
  end

  actions do
    defaults [:read, :create, :update, :destroy]
  end

  attributes do
    uuid_primary_key :id

    attribute :title, :string, do: allow_nil?(false)
    attribute :duration, :integer, do: allow_nil?(false)
    attribute :index, :integer

    attribute :number_of_plays, :integer do
      default 0
    end

    create_timestamp :created_at
    update_timestamp :updated_at
  end

  relationships do
    belongs_to :album, AshMusicDb.Album do
      attribute_writable? true
    end
  end
end
