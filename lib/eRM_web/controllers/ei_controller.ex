defmodule ERMWeb.EIController do
  use ERMWeb, :controller

  alias ERM.Cooperation
  alias ERM.Cooperation.EI

  def index(conn, _params) do
    e2s = Cooperation.list_e2s()
    render(conn, "index.html", e2s: e2s)
  end

  def new(conn, %{"type" => type, "ei_id" => ei_id, "relation" => relation} = params) do
    IO.inspect(params)
    IO.puts "new with relation"
    #parse ei_id
    # get ei_id and copy coordinates
    # create relations [hush, relation_type, from_to]
    type = String.downcase(type)
    parent_e3 = ERM.Cooperation.get_e2!(ei_id)
    IO.inspect parent_e3.geom
    changeset = Cooperation.change_e2(%EI{geom: parent_e3.geom, type: type, relation: relation})
    render(conn, "#{type}.html", changeset: changeset, relation: relation, parent_e3: parent_e3)
  end

  def new(conn, %{"type" => type} = params) do
    IO.inspect(params)
    type = String.downcase(type)
    changeset = Cooperation.change_e2(%EI{type: type})
    render(conn, "#{type}.html", changeset: changeset, relation: nil, parent_e3: nil)
  end

  def create(conn, %{"ei" => ei_params} = params) do
    IO.inspect params
    #ei_params = Map.put(ei_params,"relation", nil)
    IO.inspect ei_params
    IO.puts "create ei"
    # add create related
    case Cooperation.create_e2(ei_params) do
      {:ok, ei} ->
        IO.puts "OK e3 created"
        #broadcast! socket, "new_msg", %{body: body}
        #ERMWeb.Endpoint.broadcast("map:lobby", "new_e3", %{payload: "test"})
        #|> IO.inspect()
        ERMWeb.Endpoint.broadcast "map:lobby",
        "new_e3", %{payload: "test"}

        conn
        |> put_flash(:info, "EI created successfully.")
        |> redirect(to: erm_ei_path(conn, :show, ei))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    IO.puts "show EIs"
    e2 = Cooperation.get_e2!(id)
    IO.inspect e2
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
        |> redirect(to: erm_ei_path(conn, :show, e2))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", e2: e2, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    e2 = Cooperation.get_e2!(id)
    {:ok, _e2} = Cooperation.delete_e2(e2)

    conn
    |> put_flash(:info, "E2 deleted successfully.")
    |> redirect(to: erm_ei_path(conn, :index))
  end
end
