defmodule NixPhoenixTemplateWeb do
  @moduledoc """
  The entrypoint for defining your web interface, such
  as controllers, components, channels, and so on.

  This can be used in your application as:

      use NixPhoenixTemplateWeb, :controller
      use NixPhoenixTemplateWeb, :html

  The definitions below will be executed for every controller,
  component, etc, so keep them short and clean, focused
  on imports, uses and aliases.

  Do NOT define functions inside the quoted expressions
  below. Instead, define additional modules and import
  those modules here.
  """

  @doc """
  Render static paths for the main app (i.e. robots.txt, etc)
  """
  def static_paths, do: ~w(assets fonts images favicon.ico robots.txt)

  @doc """
  Render the main app
  """
  def router do
    quote do
      use Phoenix.Router, helpers: false

      # Import common connection and controller functions to use in pipelines
      import Plug.Conn
      import Phoenix.Controller
      import Phoenix.LiveView.Router
    end
  end

  @doc """
  Create a new websocket channel
  """
  def channel do
    quote do
      use Phoenix.Channel
    end
  end

  @doc """
  Call the phoenix controller
  """
  def controller do
    quote do
      use Phoenix.Controller,
        formats: [:html, :json],
        layouts: [html: NixPhoenixTemplateWeb.Layouts]

      import Plug.Conn
      use Gettext, backend: NixPhoenixTemplateWeb.Gettext

      unquote(verified_routes())
    end
  end

  @doc """
  Render the live view
  """
  def live_view do
    quote do
      use Phoenix.LiveView,
        layout: {NixPhoenixTemplateWeb.Layouts, :app}

      unquote(html_helpers())
    end
  end

  @doc """
  Render the live component
  """
  def live_component do
    quote do
      use Phoenix.LiveComponent

      unquote(html_helpers())
    end
  end

  @doc """
  Render html
  """
  def html do
    quote do
      use Phoenix.Component

      # Import convenience functions from controllers
      import Phoenix.Controller,
        only: [get_csrf_token: 0, view_module: 1, view_template: 1]

      # Include general helpers for rendering HTML
      unquote(html_helpers())
    end
  end

  defp html_helpers do
    quote do
      # HTML escaping functionality
      import Phoenix.HTML
      # Core UI components and translation
      import NixPhoenixTemplateWeb.CoreComponents
      use Gettext, backend: NixPhoenixTemplateWeb.Gettext

      # Shortcut for generating JS commands
      alias Phoenix.LiveView.JS

      # Routes generation with the ~p sigil
      unquote(verified_routes())
    end
  end

  @doc """
  Allow for verified routes to render
  """
  def verified_routes do
    quote do
      use Phoenix.VerifiedRoutes,
        endpoint: NixPhoenixTemplateWeb.Endpoint,
        router: NixPhoenixTemplateWeb.Router,
        statics: NixPhoenixTemplateWeb.static_paths()
    end
  end

  @doc """
  When used, dispatch to the appropriate controller/live_view/etc.
  """
  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
