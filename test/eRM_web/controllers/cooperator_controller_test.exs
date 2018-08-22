defmodule ERMWeb.CooperatorControllerTest do
  use ERMWeb.ConnCase

  alias ERM.Cooperators

  @create_attrs %{eid: "some eid", hash: "some hash", name1: "some name1", name2: "some name2", priv_key: "some priv_key", pub_key: "some pub_key"}
  @update_attrs %{eid: "some updated eid", hash: "some updated hash", name1: "some updated name1", name2: "some updated name2", priv_key: "some updated priv_key", pub_key: "some updated pub_key"}
  @invalid_attrs %{eid: nil, hash: nil, name1: nil, name2: nil, priv_key: nil, pub_key: nil}

  def fixture(:cooperator) do
    {:ok, cooperator} = Cooperators.create_cooperator(@create_attrs)
    cooperator
  end

  describe "index" do
    test "lists all cooperators", %{conn: conn} do
      conn = get conn, cooperator_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Cooperators"
    end
  end

  describe "new cooperator" do
    test "renders form", %{conn: conn} do
      conn = get conn, cooperator_path(conn, :new)
      assert html_response(conn, 200) =~ "New Cooperator"
    end
  end

  describe "create cooperator" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, cooperator_path(conn, :create), cooperator: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == cooperator_path(conn, :show, id)

      conn = get conn, cooperator_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Cooperator"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, cooperator_path(conn, :create), cooperator: @invalid_attrs
      assert html_response(conn, 200) =~ "New Cooperator"
    end
  end

  describe "edit cooperator" do
    setup [:create_cooperator]

    test "renders form for editing chosen cooperator", %{conn: conn, cooperator: cooperator} do
      conn = get conn, cooperator_path(conn, :edit, cooperator)
      assert html_response(conn, 200) =~ "Edit Cooperator"
    end
  end

  describe "update cooperator" do
    setup [:create_cooperator]

    test "redirects when data is valid", %{conn: conn, cooperator: cooperator} do
      conn = put conn, cooperator_path(conn, :update, cooperator), cooperator: @update_attrs
      assert redirected_to(conn) == cooperator_path(conn, :show, cooperator)

      conn = get conn, cooperator_path(conn, :show, cooperator)
      assert html_response(conn, 200) =~ "some updated eid"
    end

    test "renders errors when data is invalid", %{conn: conn, cooperator: cooperator} do
      conn = put conn, cooperator_path(conn, :update, cooperator), cooperator: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Cooperator"
    end
  end

  describe "delete cooperator" do
    setup [:create_cooperator]

    test "deletes chosen cooperator", %{conn: conn, cooperator: cooperator} do
      conn = delete conn, cooperator_path(conn, :delete, cooperator)
      assert redirected_to(conn) == cooperator_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, cooperator_path(conn, :show, cooperator)
      end
    end
  end

  defp create_cooperator(_) do
    cooperator = fixture(:cooperator)
    {:ok, cooperator: cooperator}
  end
end
