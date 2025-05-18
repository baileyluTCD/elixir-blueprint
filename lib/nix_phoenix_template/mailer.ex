defmodule NixPhoenixTemplate.Mailer do
  @moduledoc """
  Setup a swoosh mailer for the app
  """

  use Swoosh.Mailer, otp_app: :nix_phoenix_template
end
