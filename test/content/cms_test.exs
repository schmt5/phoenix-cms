defmodule Content.CmsTest do
  use Content.DataCase

  alias Content.Cms

  describe "entries" do
    alias Content.Cms.Entry

    import Content.CmsFixtures

    @invalid_attrs %{text: nil, slug: nil}

    test "list_entries/0 returns all entries" do
      entry = entry_fixture()
      assert Cms.list_entries() == [entry]
    end

    test "get_entry!/1 returns the entry with given id" do
      entry = entry_fixture()
      assert Cms.get_entry!(entry.id) == entry
    end

    test "create_entry/1 with valid data creates a entry" do
      valid_attrs = %{text: "some text", slug: "some slug"}

      assert {:ok, %Entry{} = entry} = Cms.create_entry(valid_attrs)
      assert entry.text == "some text"
      assert entry.slug == "some slug"
    end

    test "create_entry/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Cms.create_entry(@invalid_attrs)
    end

    test "update_entry/2 with valid data updates the entry" do
      entry = entry_fixture()
      update_attrs = %{text: "some updated text", slug: "some updated slug"}

      assert {:ok, %Entry{} = entry} = Cms.update_entry(entry, update_attrs)
      assert entry.text == "some updated text"
      assert entry.slug == "some updated slug"
    end

    test "update_entry/2 with invalid data returns error changeset" do
      entry = entry_fixture()
      assert {:error, %Ecto.Changeset{}} = Cms.update_entry(entry, @invalid_attrs)
      assert entry == Cms.get_entry!(entry.id)
    end

    test "delete_entry/1 deletes the entry" do
      entry = entry_fixture()
      assert {:ok, %Entry{}} = Cms.delete_entry(entry)
      assert_raise Ecto.NoResultsError, fn -> Cms.get_entry!(entry.id) end
    end

    test "change_entry/1 returns a entry changeset" do
      entry = entry_fixture()
      assert %Ecto.Changeset{} = Cms.change_entry(entry)
    end
  end
end
