defmodule ERM.Cooperation.FarmContent do
  @moduledoc """
  Farmer Interaction custom content.
  """
  use Ecto.Schema
  import Ecto.Changeset

  embedded_schema do
    field :first_name, :string
    field :last_name, :string
  end

  @fields ~w(first_name last_name)a

  def changeset(model, params \\ %{}) do
    model
    |> cast(params, @fields)
  end
end
