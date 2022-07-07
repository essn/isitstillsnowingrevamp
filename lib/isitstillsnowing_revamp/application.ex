defmodule IsitstillsnowingRevamp.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      {
        Plug.Cowboy,
        scheme: :http,
        plug: IsitstillsnowingRevamp.Http.Router,
        port: 4040
      }
    ]

    opts = [strategy: :one_for_one, name: IsitstillsnowingRevamp.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
