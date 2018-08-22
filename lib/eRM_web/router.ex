defmodule ERMWeb.Router do
  use ERMWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ERMWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/eis", EIController
    resources "/cooperators", CooperatorController
    resources "/sessions", SessionController, only: [:new,    :create, :delete], singleton: true
  end

  # Other scopes may use custom stacks.
  # scope "/api", ERMWeb do
  #   pipe_through :api
  # end

  defp authenticate_user(conn, _) do
    case get_session(conn, :cooperator_id) do
      nil ->
        conn
        |> Phoenix.Controller.put_flash(:error, "Login required")
        |> Phoenix.Controller.redirect(to: "/")
        |> halt()
      cooperator_id ->
        assign(conn, :current_cooperator, ERM.Cooperators.get_cooperator!(cooperator_id))
    end
  end
end
