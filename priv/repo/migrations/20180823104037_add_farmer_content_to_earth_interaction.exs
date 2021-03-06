defmodule ERM.Repo.Migrations.AddFarmerContentToEarthInteraction do
  use Ecto.Migration

  def change do
    alter table(:eis) do
      add :measurement_content, :map
      add :farmer_content, :map
      add :project_content, :map
      add :farm_content, :map
      add :content, :map
    end

  end
end
