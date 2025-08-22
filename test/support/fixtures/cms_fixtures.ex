defmodule Content.CmsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Content.Cms` context.
  """

  @doc """
  Generate a entry.
  """
  def entry_fixture(attrs \\ %{}) do
    {:ok, entry} =
      attrs
      |> Enum.into(%{
        slug: "some slug",
        text: "some text"
      })
      |> Content.Cms.create_entry()

    entry
  end
end
