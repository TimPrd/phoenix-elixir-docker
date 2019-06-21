defmodule Hello.Application do
    use Application
    require Logger

    def start(_type, _args) do
      import Supervisor.Spec
  
      children = [
        supervisor(Hello.Repo, []),
        supervisor(HelloWeb.Endpoint, []),
        worker(Hello.Scheduler, []),
      ]
  
      opts = [strategy: :one_for_one, name: Hello.Supervisor]
      Supervisor.start_link(children, opts)
    end
  
    def config_change(changed, _new, removed) do
        Hello.Endpoint.config_change(changed, removed)
      :ok
    end
  end