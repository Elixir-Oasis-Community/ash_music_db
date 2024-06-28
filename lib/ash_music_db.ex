defmodule AshMusicDb do
  use Ash.Domain

  require Ash.Query

  resources do
    resource AshMusicDb.Album
    resource AshMusicDb.AlbumGenre
    resource AshMusicDb.Artist
    resource AshMusicDb.Band
    resource AshMusicDb.Genre
    resource AshMusicDb.Track
  end

  # artist
  def create_artist(name \\ "John Doe") do
    AshMusicDb.Artist
    |> Ash.Changeset.for_create(:create, %{name: name})
    |> Ash.create!()
  end

  def fetch_all_artists, do: Ash.read!(AshMusicDb.Artist)

  def fetch_artist(name \\ "John Doe") do
    AshMusicDb.Artist
    |> Ash.Query.filter(name == ^name)
    |> Ash.read!()
  end

  def update_artist(artist) do
    artist
    |> Ash.Changeset.for_update(:update, %{name: "Dolly Parton"})
    |> Ash.update!()
  end

  def destroy_artist(artist), do: Ash.destroy!(artist)

  # band
  def create_band(name, status) do
    AshMusicDb.Band
    |> Ash.Changeset.for_create(:create, %{name: name, status: status})
    |> Ash.create!()
  end

  def create_band_active(name) do
    AshMusicDb.Band
    |> Ash.Changeset.for_create(:active, %{name: name})
    |> Ash.create!()
  end

  def udpate_band_inactive(band) do
    band
    |> Ash.Changeset.for_update(:inactive)
    |> Ash.update!()
  end

  # album
  def create_album(title \\ "Banana") do
    AshMusicDb.Album
    |> Ash.Changeset.for_create(:create, %{title: title, add_genre: %{name: "Yellow"}})
    |> Ash.create!()
  end

  def most_recently_added(entity) do
    entity
    |> Ash.Query.sort(created_at: :desc)
    |> Ash.Query.limit(1)
    |> Ash.read_one!()
  end
end
