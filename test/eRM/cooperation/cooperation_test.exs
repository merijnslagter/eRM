defmodule ERM.CooperationTest do
  use ERM.DataCase

  alias ERM.Cooperation

  describe "e2s" do
    alias ERM.Cooperation.EI

    @valid_attrs %{creator: "some creator", date: "2010-04-17 14:00:00.000000Z", description: "some description", eid: "some eid", hash: "some hash", signature: "some signature", type: "some type"}
    @update_attrs %{creator: "some updated creator", date: "2011-05-18 15:01:01.000000Z", description: "some updated description", eid: "some updated eid", hash: "some updated hash", signature: "some updated signature", type: "some updated type"}
    @invalid_attrs %{creator: nil, date: nil, description: nil, eid: nil, hash: nil, signature: nil, type: nil}

    def e2_fixture(attrs \\ %{}) do
      {:ok, e2} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Cooperation.create_e2()

      e2
    end

    test "list_e2s/0 returns all e2s" do
      e2 = e2_fixture()
      assert Cooperation.list_e2s() == [e2]
    end

    test "get_e2!/1 returns the e2 with given id" do
      e2 = e2_fixture()
      assert Cooperation.get_e2!(e2.id) == e2
    end

    test "create_e2/1 with valid data creates a e2" do
      assert {:ok, %E2{} = e2} = Cooperation.create_e2(@valid_attrs)
      assert e2.creator == "some creator"
      assert e2.date == DateTime.from_naive!(~N[2010-04-17 14:00:00.000000Z], "Etc/UTC")
      assert e2.description == "some description"
      assert e2.eid == "some eid"
      assert e2.hash == "some hash"
      assert e2.signature == "some signature"
      assert e2.type == "some type"
    end

    test "create_e2/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Cooperation.create_e2(@invalid_attrs)
    end

    test "update_e2/2 with valid data updates the e2" do
      e2 = e2_fixture()
      assert {:ok, e2} = Cooperation.update_e2(e2, @update_attrs)
      assert %E2{} = e2
      assert e2.creator == "some updated creator"
      assert e2.date == DateTime.from_naive!(~N[2011-05-18 15:01:01.000000Z], "Etc/UTC")
      assert e2.description == "some updated description"
      assert e2.eid == "some updated eid"
      assert e2.hash == "some updated hash"
      assert e2.signature == "some updated signature"
      assert e2.type == "some updated type"
    end

    test "update_e2/2 with invalid data returns error changeset" do
      e2 = e2_fixture()
      assert {:error, %Ecto.Changeset{}} = Cooperation.update_e2(e2, @invalid_attrs)
      assert e2 == Cooperation.get_e2!(e2.id)
    end

    test "delete_e2/1 deletes the e2" do
      e2 = e2_fixture()
      assert {:ok, %E2{}} = Cooperation.delete_e2(e2)
      assert_raise Ecto.NoResultsError, fn -> Cooperation.get_e2!(e2.id) end
    end

    test "change_e2/1 returns a e2 changeset" do
      e2 = e2_fixture()
      assert %Ecto.Changeset{} = Cooperation.change_e2(e2)
    end
  end

  describe "credentials" do
    alias ERM.Cooperation.Credential

    @valid_attrs %{email: "some email", password_hash: "some password_hash"}
    @update_attrs %{email: "some updated email", password_hash: "some updated password_hash"}
    @invalid_attrs %{email: nil, password_hash: nil}

    def credential_fixture(attrs \\ %{}) do
      {:ok, credential} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Cooperation.create_credential()

      credential
    end

    test "list_credentials/0 returns all credentials" do
      credential = credential_fixture()
      assert Cooperation.list_credentials() == [credential]
    end

    test "get_credential!/1 returns the credential with given id" do
      credential = credential_fixture()
      assert Cooperation.get_credential!(credential.id) == credential
    end

    test "create_credential/1 with valid data creates a credential" do
      assert {:ok, %Credential{} = credential} = Cooperation.create_credential(@valid_attrs)
      assert credential.email == "some email"
      assert credential.password_hash == "some password_hash"
    end

    test "create_credential/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Cooperation.create_credential(@invalid_attrs)
    end

    test "update_credential/2 with valid data updates the credential" do
      credential = credential_fixture()
      assert {:ok, credential} = Cooperation.update_credential(credential, @update_attrs)
      assert %Credential{} = credential
      assert credential.email == "some updated email"
      assert credential.password_hash == "some updated password_hash"
    end

    test "update_credential/2 with invalid data returns error changeset" do
      credential = credential_fixture()
      assert {:error, %Ecto.Changeset{}} = Cooperation.update_credential(credential, @invalid_attrs)
      assert credential == Cooperation.get_credential!(credential.id)
    end

    test "delete_credential/1 deletes the credential" do
      credential = credential_fixture()
      assert {:ok, %Credential{}} = Cooperation.delete_credential(credential)
      assert_raise Ecto.NoResultsError, fn -> Cooperation.get_credential!(credential.id) end
    end

    test "change_credential/1 returns a credential changeset" do
      credential = credential_fixture()
      assert %Ecto.Changeset{} = Cooperation.change_credential(credential)
    end
  end
end
