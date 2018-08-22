defmodule ERMWeb.EIController do
  use ERMWeb, :controller

  alias ERM.Cooperation
  alias ERM.Cooperation.EI

  def index(conn, _params) do
    e2s = Cooperation.list_e2s()
    render(conn, "index.html", e2s: e2s)
  end

  def new(conn, _params) do
    changeset = Cooperation.change_e2(%EI{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"ei" => e2_params}) do
    case Cooperation.create_e2(e2_params) do
      {:ok, e2} ->
        conn
        |> put_flash(:info, "E2 created successfully.")
        |> redirect(to: ei_path(conn, :show, e2))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    e2 = Cooperation.get_e2!(id)
    render(conn, "show.html", e2: e2)
  end

  def edit(conn, %{"id" => id}) do
    e2 = Cooperation.get_e2!(id)
    changeset = Cooperation.change_e2(e2)
    render(conn, "edit.html", e2: e2, changeset: changeset)
  end

  def update(conn, %{"id" => id, "ei" => e2_params}) do
    e2 = Cooperation.get_e2!(id)

    case Cooperation.update_e2(e2, e2_params) do
      {:ok, e2} ->
        conn
        |> put_flash(:info, "E2 updated successfully.")
        |> redirect(to: ei_path(conn, :show, e2))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", e2: e2, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    e2 = Cooperation.get_e2!(id)
    {:ok, _e2} = Cooperation.delete_e2(e2)

    conn
    |> put_flash(:info, "E2 deleted successfully.")
    |> redirect(to: ei_path(conn, :index))
  end
end
