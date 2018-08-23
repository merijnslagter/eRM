defmodule ERM.Cooperation.MeasurementContent do
  @moduledoc """
  Measurement Interaction custom content.
  """
  use Ecto.Schema
  import Ecto.Changeset

  embedded_schema do
    field :description, :string
    field :period, :string
    field :value, :string
    field :date, :utc_datetime
  end

  @fields ~w(description period value date)a

  def changeset(model, params \\ %{}) do
    model
    |> cast(params, @fields)
  end
end
