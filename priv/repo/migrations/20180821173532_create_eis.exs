defmodule ERM.Repo.Migrations.CreateE2s do
  use Ecto.Migration

  def change do
    create table(:eis) do
      add :type, :string
      add :creator, :string
      add :date, :utc_datetime
      add :hash, :string
      add :signature, :string
      add :eid, :string
      add :description, :string
      add :geom,     :geometry

      timestamps()
    end

  end
end
