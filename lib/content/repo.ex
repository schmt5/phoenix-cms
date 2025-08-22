defmodule Content.Repo do
  use Ecto.Repo,
    otp_app: :content,
    adapter: Ecto.Adapters.SQLite3
end
