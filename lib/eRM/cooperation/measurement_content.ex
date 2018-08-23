defmodule ERM.Cooperation.MeasurementContent do
  @moduledoc """
  Measurement Interaction custom content.
  """
  use Ecto.Schema
  import Ecto.Changeset

  embedded_schema do
    field :ph, :string
    field :biodiversity_index, :string
  end

  @fields ~w(ph biodiversity_index)a

  def changeset(model, params \\ %{}) do
    model
    |> cast(params, @fields)
  end
end
