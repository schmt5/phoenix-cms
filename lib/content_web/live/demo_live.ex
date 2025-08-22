defmodule ContentWeb.DemoLive do
  use ContentWeb, :live_view

  alias Content.Cms

  def mount(_params, _session, socket) do
    entries = Cms.list_entries()
    entries_by_slug = Map.new(entries, fn entry -> {entry.slug, entry.text} end)

    {:ok, socket |> assign(:entries_by_slug, entries_by_slug) |> assign(:entries, entries)}
  end

  def handle_event("set_content", %{"slug" => slug, "text" => text}, socket) do
    entry = Cms.get_by(slug)

    attrs = %{
      text: text,
      slug: slug
    }

    if entry do
      {:ok, _entry} = Content.Cms.update_entry(entry, attrs)

      entries_by_slug = socket.assigns.entries_by_slug |> Map.put(slug, text)
      {:noreply, socket |> assign(:entries_by_slug, entries_by_slug)}
    else
      {:ok, entry} = Content.Cms.create_entry(attrs)

      entries_by_slug = socket.assigns.entries_by_slug |> Map.put(slug, entry.text)
      {:noreply, socket |> assign(:entries_by_slug, entries_by_slug)}
    end
  end
end
