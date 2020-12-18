defmodule Tex.Repo do
  use Ecto.Repo,
    otp_app: :tex,
    adapter: Ecto.Adapters.Postgres
end
