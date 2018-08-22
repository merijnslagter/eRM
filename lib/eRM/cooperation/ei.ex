defmodule ERM.Cooperation.EI do
  use Ecto.Schema
  import Ecto.Changeset


  schema "eis" do
    field :creator, :string
    field :date, :utc_datetime
    field :description, :string
    field :eid, :string
    field :hash, :string
    field :signature, :string
    field :type, :string
    field :geom, Geo.PostGIS.Geometry

    timestamps()
  end

  @doc false
  def changeset(ei, attrs) do
    ei
    |> cast(attrs, [:type, :date, :hash, :description, :geom])
    |> validate_required([:type, :date, :description])
  end
end
