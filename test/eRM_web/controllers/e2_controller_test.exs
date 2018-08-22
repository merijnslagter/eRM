defmodule ERMWeb.E2ControllerTest do
  use ERMWeb.ConnCase

  alias ERM.Cooperation

  @create_attrs %{creator: "some creator", date: "2010-04-17 14:00:00.000000Z", description: "some description", eid: "some eid", hash: "some hash", signature: "some signature", type: "some type"}
  @update_attrs %{creator: "some updated creator", date: "2011-05-18 15:01:01.000000Z", description: "some updated description", eid: "some updated eid", hash: "some updated hash", signature: "some updated signature", type: "some updated type"}
  @invalid_attrs %{creator: nil, date: nil, description: nil, eid: nil, hash: nil, signature: nil, type: nil}

  def fixture(:e2) do
    {:ok, e2} = Cooperation.create_e2(@create_attrs)
    e2
  end

  describe "index" do
    test "lists all e2s", %{conn: conn} do
      conn = get conn, e2_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing E2s"
    end
  end

  describe "new e2" do
    test "renders form", %{conn: conn} do
      conn = get conn, e2_path(conn, :new)
      assert html_response(conn, 200) =~ "New E2"
    end
  end

  describe "create e2" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, e2_path(conn, :create), e2: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == e2_path(conn, :show, id)

      conn = get conn, e2_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show E2"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, e2_path(conn, :create), e2: @invalid_attrs
      assert html_response(conn, 200) =~ "New E2"
    end
  end

  describe "edit e2" do
    setup [:create_e2]

    test "renders form for editing chosen e2", %{conn: conn, e2: e2} do
      conn = get conn, e2_path(conn, :edit, e2)
      assert html_response(conn, 200) =~ "Edit E2"
    end
  end

  describe "update e2" do
    setup [:create_e2]

    test "redirects when data is valid", %{conn: conn, e2: e2} do
      conn = put conn, e2_path(conn, :update, e2), e2: @update_attrs
      assert redirected_to(conn) == e2_path(conn, :show, e2)

      conn = get conn, e2_path(conn, :show, e2)
      assert html_response(conn, 200) =~ "some updated creator"
    end

    test "renders errors when data is invalid", %{conn: conn, e2: e2} do
      conn = put conn, e2_path(conn, :update, e2), e2: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit E2"
    end
  end

  describe "delete e2" do
    setup [:create_e2]

    test "deletes chosen e2", %{conn: conn, e2: e2} do
      conn = delete conn, e2_path(conn, :delete, e2)
      assert redirected_to(conn) == e2_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, e2_path(conn, :show, e2)
      end
    end
  end

  defp create_e2(_) do
    e2 = fixture(:e2)
    {:ok, e2: e2}
  end
end
