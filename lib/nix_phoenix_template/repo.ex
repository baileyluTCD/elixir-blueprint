defmodule NixPhoenixTemplate.Repo do
  @moduledoc """
  Setup an ecto repo for the app
  """

  use Ecto.Repo,
    otp_app: :nix_phoenix_template,
    adapter: Ecto.Adapters.Postgres
end
