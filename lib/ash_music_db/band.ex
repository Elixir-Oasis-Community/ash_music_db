defmodule AshMusicDb.Band do
  use Ash.Resource, domain: AshMusicDb, data_layer: AshPostgres.DataLayer

  postgres do
    table "bands"
    repo(AshMusicDb.Repo)
  end

  actions do
    defaults [:read, :update, :destroy]

    create :create do
      accept [:name, :status]
    end

    create :active do
      accept [:name]

      change set_attribute(:status, :active)
    end

    update :inactive do
      accept []

      change set_attribute(:status, :inactive)
    end
  end

  attributes do
    uuid_primary_key :id

    attribute :name, :string, do: allow_nil?(false)
    attribute :year_started, :date
    attribute :year_ended, :date

    attribute :status, :atom do
      constraints one_of: [:active, :inactive]
    end

    create_timestamp :created_at
    update_timestamp :updated_at
  end
end
