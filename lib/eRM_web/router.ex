defmodule ERMWeb.Router do
  use ERMWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :put_user_token
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ERMWeb do
    pipe_through :browser # Use the default browser stack
    resources "/sessions", SessionController, only: [:new,    :create, :delete], singleton: true

    get "/", PageController, :index
    resources "/eis", EIController
    resources "/cooperators", CooperatorController

  end

  scope "/erm", ERMWeb, as: :erm do
    pipe_through [:browser, :authenticate_user]

    get "/", PageController, :index
    resources "/eis", EIController
    resources "/cooperators", CooperatorController
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

  defp put_user_token(conn, _) do
    if current_cooperator = conn.assigns[:current_cooperator] do
      token = Phoenix.Token.sign(conn, "cooperator socket", current_cooperator.id)
      assign(conn, :user_token, token)
    else
      conn
    end
  end
end
