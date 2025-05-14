defmodule NixPhoenixTemplate.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      NixPhoenixTemplateWeb.Telemetry,
      NixPhoenixTemplate.Repo,
      {DNSCluster, query: Application.get_env(:nix_phoenix_template, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: NixPhoenixTemplate.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: NixPhoenixTemplate.Finch},
      # Start a worker by calling: NixPhoenixTemplate.Worker.start_link(arg)
      # {NixPhoenixTemplate.Worker, arg},
      # Start to serve requests, typically the last entry
      NixPhoenixTemplateWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: NixPhoenixTemplate.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    NixPhoenixTemplateWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
