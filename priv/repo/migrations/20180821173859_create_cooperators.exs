defmodule ERM.Repo.Migrations.CreateCooperators do
  use Ecto.Migration

  def change do
    create table(:cooperators) do
      add :pub_key, :string
      add :priv_key, :string
      add :hash, :string
      add :name1, :string
      add :name2, :string
      add :eid, :string

      timestamps()
    end

  end
end
