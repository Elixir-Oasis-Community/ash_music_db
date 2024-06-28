defmodule AshMusicDb.Repo do
  use AshPostgres.Repo, otp_app: :ash_music_db

  def installed_extensions do
    ["ash-functions", "uuid-ossp", "citext"]
  end
end
