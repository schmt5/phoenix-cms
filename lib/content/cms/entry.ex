defmodule Content.Cms.Entry do
  use Ecto.Schema
  import Ecto.Changeset

  schema "entries" do
    field :text, :string
    field :slug, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(entry, attrs) do
    entry
    |> cast(attrs, [:text, :slug])
    |> validate_required([:text, :slug])
  end
end
