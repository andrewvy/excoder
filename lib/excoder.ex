defmodule Excoder do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec

    children = [
      supervisor(Excoder.Pool, [])
    ]

    opts = [strategy: :one_for_one, name: Excoder.Supervisor]

    Supervisor.start_link(children, opts)
  end
end
