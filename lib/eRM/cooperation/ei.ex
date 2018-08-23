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
    field :relation, :string, virtual: true

    embeds_one :farmer_content, ERM.Cooperation.FarmerContent, on_replace: :delete
    embeds_one :farm_content, ERM.Cooperation.FarmContent, on_replace: :delete
    embeds_one :project_content, ERM.Cooperation.ProjectContent, on_replace: :delete
    embeds_one :measurement_content, ERM.Cooperation.MeasurementContent, on_replace: :delete

    timestamps()
  end

  @doc false
  def changeset(ei, attrs) do
    ei
    |> cast(attrs, [:type, :date, :hash, :description, :geom])
    |> validate_required([:type, :description])
  end

  @doc false
  def create_changeset(ei, attrs) do
    IO.puts "create_changeset"
    IO.inspect(attrs)
      ei
      |> cast(attrs, [:type, :date, :hash, :description, :geom])
      |> validate_required([:type, :description])
      |> cast_content()
  end

  defp cast_content(changeset) do
    type = changeset.changes.type
    case type do
      "FARMER" -> cast_content(changeset, :farmer_content)
      "FARM" -> cast_content(changeset, :farm_content)
      "PROJECT" -> cast_content(changeset, :project_content)
      "MEASUREMENT" -> cast_content(changeset, :measurement_content)
      _ -> raise "not recognized type: #{type}"
    end
  end
  defp cast_content(changeset, :farm_content = embed_name) do
    #ensured_content = changeset.params. || %{}
    #changeset
    #|> put_embed(embed_name, ensured_content)
    #|> cast_embed(embed_name, required: true)

    changeset
    |> cast_embed(embed_name, required: false)
  end

  defp cast_content(changeset, :measurement_content = embed_name) do
    #ensured_content = changeset.params. || %{}
    #changeset
    #|> put_embed(embed_name, ensured_content)
    #|> cast_embed(embed_name, required: true)

    changeset
    |> cast_embed(embed_name, required: true)
  end
end
