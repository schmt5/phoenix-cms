defmodule ContentWeb.PageController do
  use ContentWeb, :controller

  alias Content.Cms

  def home(conn, _params) do
    entries = Cms.list_entries()
    entries_by_slug = Map.new(entries, fn entry -> {entry.slug, entry.text} end)

    conn
    |> assign(:page_title, "Welcome to Phoenix CMS")
    |> assign(:subtitle, "Manage your content effortlessly")
    |> assign(:entries, entries_by_slug)
    |> render(:home)
  end
end
