defmodule Content.Repo.Migrations.CreateEntries do
  use Ecto.Migration

  def change do
    create table(:entries) do
      add :text, :text
      add :slug, :string

      timestamps(type: :utc_datetime)
    end
  end
end
