defmodule ERM.Cooperators.Cooperator do
  use Ecto.Schema
  import Ecto.Changeset

  alias ERM.Cooperators.Credential


  schema "cooperators" do
    field :eid, :string
    field :hash, :string
    field :name1, :string
    field :name2, :string
    field :priv_key, :string
    field :pub_key, :string
    has_one :credential, Credential, foreign_key: :cooperator_id,
    on_delete: :delete_all

    timestamps()
  end

  @doc false
  def changeset(cooperator, attrs) do
    cooperator
    |> cast(attrs, [:name1, :name2])
    |> validate_required([:name1, :name2])
  end
end
