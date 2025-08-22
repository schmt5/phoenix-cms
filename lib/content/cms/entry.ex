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
    |> sanitize_text()
  end

  defp sanitize_text(changeset) do
    case get_change(changeset, :text) do
      nil ->
        changeset

      text ->
        # Allow basic formatting tags, strip dangerous ones
        sanitized = HtmlSanitizeEx.basic_html(text) |> String.trim()
        put_change(changeset, :text, sanitized)
    end
  end
end
