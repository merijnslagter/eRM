defmodule ERM.Cooperation.ProjectContent do
  @moduledoc """
  Project Interaction custom content.
  """
  use Ecto.Schema
  import Ecto.Changeset

  embedded_schema do
    field :name, :string
  end

  @fields ~w(name)a

  def changeset(model, params \\ %{}) do
    model
    |> cast(params, @fields)
  end
end
