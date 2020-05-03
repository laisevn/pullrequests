defmodule Pullrequests.Repo do
  use Ecto.Repo,
    otp_app: :pullrequests,
    adapter: Ecto.Adapters.Postgres
end
