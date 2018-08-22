defmodule ERMWeb.SessionController do
  use ERMWeb, :controller

  alias ERM.Cooperators

  def new(conn, _) do
    render(conn, "new.html")
  end

  def create(conn, %{"user" => %{"email" => email, "password" => password}}) do
    case Cooperators.authenticate_by_email_password(email, password) do
      {:ok, cooperator} ->
        conn
        |> put_flash(:info, "Welcome back!")
        |> put_session(:cooperator_id, cooperator.id)
        |> configure_session(renew: true)
        |> redirect(to: "/")
      {:error, :unauthorized} ->
        conn
        |> put_flash(:error, "Bad email/password combination")
        |> redirect(to: session_path(conn, :new))
    end
  end

  def delete(conn, _) do
    conn
    |> configure_session(drop: true)
    |> redirect(to: "/")
  end
end
