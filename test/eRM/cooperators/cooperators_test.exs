defmodule ERM.CooperatorsTest do
  use ERM.DataCase

  alias ERM.Cooperators

  describe "cooperators" do
    alias ERM.Cooperators.Cooperator

    @valid_attrs %{creator: "some creator", date: "2010-04-17 14:00:00.000000Z", description: "some description", eid: "some eid", hash: "some hash", signature: "some signature", type: "some type"}
    @update_attrs %{creator: "some updated creator", date: "2011-05-18 15:01:01.000000Z", description: "some updated description", eid: "some updated eid", hash: "some updated hash", signature: "some updated signature", type: "some updated type"}
    @invalid_attrs %{creator: nil, date: nil, description: nil, eid: nil, hash: nil, signature: nil, type: nil}

    def cooperator_fixture(attrs \\ %{}) do
      {:ok, cooperator} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Cooperators.create_cooperator()

      cooperator
    end

    test "list_cooperators/0 returns all cooperators" do
      cooperator = cooperator_fixture()
      assert Cooperators.list_cooperators() == [cooperator]
    end

    test "get_cooperator!/1 returns the cooperator with given id" do
      cooperator = cooperator_fixture()
      assert Cooperators.get_cooperator!(cooperator.id) == cooperator
    end

    test "create_cooperator/1 with valid data creates a cooperator" do
      assert {:ok, %Cooperator{} = cooperator} = Cooperators.create_cooperator(@valid_attrs)
      assert cooperator.creator == "some creator"
      assert cooperator.date == DateTime.from_naive!(~N[2010-04-17 14:00:00.000000Z], "Etc/UTC")
      assert cooperator.description == "some description"
      assert cooperator.eid == "some eid"
      assert cooperator.hash == "some hash"
      assert cooperator.signature == "some signature"
      assert cooperator.type == "some type"
    end

    test "create_cooperator/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Cooperators.create_cooperator(@invalid_attrs)
    end

    test "update_cooperator/2 with valid data updates the cooperator" do
      cooperator = cooperator_fixture()
      assert {:ok, cooperator} = Cooperators.update_cooperator(cooperator, @update_attrs)
      assert %Cooperator{} = cooperator
      assert cooperator.creator == "some updated creator"
      assert cooperator.date == DateTime.from_naive!(~N[2011-05-18 15:01:01.000000Z], "Etc/UTC")
      assert cooperator.description == "some updated description"
      assert cooperator.eid == "some updated eid"
      assert cooperator.hash == "some updated hash"
      assert cooperator.signature == "some updated signature"
      assert cooperator.type == "some updated type"
    end

    test "update_cooperator/2 with invalid data returns error changeset" do
      cooperator = cooperator_fixture()
      assert {:error, %Ecto.Changeset{}} = Cooperators.update_cooperator(cooperator, @invalid_attrs)
      assert cooperator == Cooperators.get_cooperator!(cooperator.id)
    end

    test "delete_cooperator/1 deletes the cooperator" do
      cooperator = cooperator_fixture()
      assert {:ok, %Cooperator{}} = Cooperators.delete_cooperator(cooperator)
      assert_raise Ecto.NoResultsError, fn -> Cooperators.get_cooperator!(cooperator.id) end
    end

    test "change_cooperator/1 returns a cooperator changeset" do
      cooperator = cooperator_fixture()
      assert %Ecto.Changeset{} = Cooperators.change_cooperator(cooperator)
    end
  end

  describe "e2s" do
    alias ERM.Cooperators.E2

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def e2_fixture(attrs \\ %{}) do
      {:ok, e2} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Cooperators.create_e2()

      e2
    end

    test "list_e2s/0 returns all e2s" do
      e2 = e2_fixture()
      assert Cooperators.list_e2s() == [e2]
    end

    test "get_e2!/1 returns the e2 with given id" do
      e2 = e2_fixture()
      assert Cooperators.get_e2!(e2.id) == e2
    end

    test "create_e2/1 with valid data creates a e2" do
      assert {:ok, %E2{} = e2} = Cooperators.create_e2(@valid_attrs)
    end

    test "create_e2/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Cooperators.create_e2(@invalid_attrs)
    end

    test "update_e2/2 with valid data updates the e2" do
      e2 = e2_fixture()
      assert {:ok, e2} = Cooperators.update_e2(e2, @update_attrs)
      assert %E2{} = e2
    end

    test "update_e2/2 with invalid data returns error changeset" do
      e2 = e2_fixture()
      assert {:error, %Ecto.Changeset{}} = Cooperators.update_e2(e2, @invalid_attrs)
      assert e2 == Cooperators.get_e2!(e2.id)
    end

    test "delete_e2/1 deletes the e2" do
      e2 = e2_fixture()
      assert {:ok, %E2{}} = Cooperators.delete_e2(e2)
      assert_raise Ecto.NoResultsError, fn -> Cooperators.get_e2!(e2.id) end
    end

    test "change_e2/1 returns a e2 changeset" do
      e2 = e2_fixture()
      assert %Ecto.Changeset{} = Cooperators.change_e2(e2)
    end
  end

  describe "e2s" do
    alias ERM.Cooperators.E2

    @valid_attrs %{eid: "some eid", hash: "some hash", name1: "some name1", name2: "some name2", priv_key: "some priv_key", pub_key: "some pub_key"}
    @update_attrs %{eid: "some updated eid", hash: "some updated hash", name1: "some updated name1", name2: "some updated name2", priv_key: "some updated priv_key", pub_key: "some updated pub_key"}
    @invalid_attrs %{eid: nil, hash: nil, name1: nil, name2: nil, priv_key: nil, pub_key: nil}

    def e2_fixture(attrs \\ %{}) do
      {:ok, e2} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Cooperators.create_e2()

      e2
    end

    test "list_e2s/0 returns all e2s" do
      e2 = e2_fixture()
      assert Cooperators.list_e2s() == [e2]
    end

    test "get_e2!/1 returns the e2 with given id" do
      e2 = e2_fixture()
      assert Cooperators.get_e2!(e2.id) == e2
    end

    test "create_e2/1 with valid data creates a e2" do
      assert {:ok, %E2{} = e2} = Cooperators.create_e2(@valid_attrs)
      assert e2.eid == "some eid"
      assert e2.hash == "some hash"
      assert e2.name1 == "some name1"
      assert e2.name2 == "some name2"
      assert e2.priv_key == "some priv_key"
      assert e2.pub_key == "some pub_key"
    end

    test "create_e2/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Cooperators.create_e2(@invalid_attrs)
    end

    test "update_e2/2 with valid data updates the e2" do
      e2 = e2_fixture()
      assert {:ok, e2} = Cooperators.update_e2(e2, @update_attrs)
      assert %E2{} = e2
      assert e2.eid == "some updated eid"
      assert e2.hash == "some updated hash"
      assert e2.name1 == "some updated name1"
      assert e2.name2 == "some updated name2"
      assert e2.priv_key == "some updated priv_key"
      assert e2.pub_key == "some updated pub_key"
    end

    test "update_e2/2 with invalid data returns error changeset" do
      e2 = e2_fixture()
      assert {:error, %Ecto.Changeset{}} = Cooperators.update_e2(e2, @invalid_attrs)
      assert e2 == Cooperators.get_e2!(e2.id)
    end

    test "delete_e2/1 deletes the e2" do
      e2 = e2_fixture()
      assert {:ok, %E2{}} = Cooperators.delete_e2(e2)
      assert_raise Ecto.NoResultsError, fn -> Cooperators.get_e2!(e2.id) end
    end

    test "change_e2/1 returns a e2 changeset" do
      e2 = e2_fixture()
      assert %Ecto.Changeset{} = Cooperators.change_e2(e2)
    end
  end

  describe "cooperators" do
    alias ERM.Cooperators.Cooperator

    @valid_attrs %{eid: "some eid", hash: "some hash", name1: "some name1", name2: "some name2", priv_key: "some priv_key", pub_key: "some pub_key"}
    @update_attrs %{eid: "some updated eid", hash: "some updated hash", name1: "some updated name1", name2: "some updated name2", priv_key: "some updated priv_key", pub_key: "some updated pub_key"}
    @invalid_attrs %{eid: nil, hash: nil, name1: nil, name2: nil, priv_key: nil, pub_key: nil}

    def cooperator_fixture(attrs \\ %{}) do
      {:ok, cooperator} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Cooperators.create_cooperator()

      cooperator
    end

    test "list_cooperators/0 returns all cooperators" do
      cooperator = cooperator_fixture()
      assert Cooperators.list_cooperators() == [cooperator]
    end

    test "get_cooperator!/1 returns the cooperator with given id" do
      cooperator = cooperator_fixture()
      assert Cooperators.get_cooperator!(cooperator.id) == cooperator
    end

    test "create_cooperator/1 with valid data creates a cooperator" do
      assert {:ok, %Cooperator{} = cooperator} = Cooperators.create_cooperator(@valid_attrs)
      assert cooperator.eid == "some eid"
      assert cooperator.hash == "some hash"
      assert cooperator.name1 == "some name1"
      assert cooperator.name2 == "some name2"
      assert cooperator.priv_key == "some priv_key"
      assert cooperator.pub_key == "some pub_key"
    end

    test "create_cooperator/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Cooperators.create_cooperator(@invalid_attrs)
    end

    test "update_cooperator/2 with valid data updates the cooperator" do
      cooperator = cooperator_fixture()
      assert {:ok, cooperator} = Cooperators.update_cooperator(cooperator, @update_attrs)
      assert %Cooperator{} = cooperator
      assert cooperator.eid == "some updated eid"
      assert cooperator.hash == "some updated hash"
      assert cooperator.name1 == "some updated name1"
      assert cooperator.name2 == "some updated name2"
      assert cooperator.priv_key == "some updated priv_key"
      assert cooperator.pub_key == "some updated pub_key"
    end

    test "update_cooperator/2 with invalid data returns error changeset" do
      cooperator = cooperator_fixture()
      assert {:error, %Ecto.Changeset{}} = Cooperators.update_cooperator(cooperator, @invalid_attrs)
      assert cooperator == Cooperators.get_cooperator!(cooperator.id)
    end

    test "delete_cooperator/1 deletes the cooperator" do
      cooperator = cooperator_fixture()
      assert {:ok, %Cooperator{}} = Cooperators.delete_cooperator(cooperator)
      assert_raise Ecto.NoResultsError, fn -> Cooperators.get_cooperator!(cooperator.id) end
    end

    test "change_cooperator/1 returns a cooperator changeset" do
      cooperator = cooperator_fixture()
      assert %Ecto.Changeset{} = Cooperators.change_cooperator(cooperator)
    end
  end
end
