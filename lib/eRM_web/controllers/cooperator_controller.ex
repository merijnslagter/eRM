defmodule ERMWeb.CooperatorController do
  use ERMWeb, :controller

  alias ERM.Cooperators
  alias ERM.Cooperators.Cooperator

  def index(conn, _params) do
    cooperators = Cooperators.list_cooperators()
    render(conn, "index.html", cooperators: cooperators)
  end

  def new(conn, _params) do
    changeset = Cooperators.change_cooperator(%Cooperator{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"cooperator" => cooperator_params}) do
    IO.inspect cooperator_params
    case Cooperators.create_cooperator(cooperator_params) do
      {:ok, cooperator} ->
        conn
        |> put_flash(:info, "Cooperator created successfully.")
        |> redirect(to: cooperator_path(conn, :show, cooperator))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    cooperator = Cooperators.get_cooperator!(id)
    render(conn, "show.html", cooperator: cooperator)
  end

  def edit(conn, %{"id" => id}) do
    cooperator = Cooperators.get_cooperator!(id)
    changeset = Cooperators.change_cooperator(cooperator)
    render(conn, "edit.html", cooperator: cooperator, changeset: changeset)
  end

  def update(conn, %{"id" => id, "cooperator" => cooperator_params}) do
    cooperator = Cooperators.get_cooperator!(id)

    case Cooperators.update_cooperator(cooperator, cooperator_params) do
      {:ok, cooperator} ->
        conn
        |> put_flash(:info, "Cooperator updated successfully.")
        |> redirect(to: cooperator_path(conn, :show, cooperator))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", cooperator: cooperator, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    cooperator = Cooperators.get_cooperator!(id)
    {:ok, _cooperator} = Cooperators.delete_cooperator(cooperator)

    conn
    |> put_flash(:info, "Cooperator deleted successfully.")
    |> redirect(to: cooperator_path(conn, :index))
  end
end
