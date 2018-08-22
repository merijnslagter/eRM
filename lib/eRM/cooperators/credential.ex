defmodule ERM.Cooperators.Credential do
  use Ecto.Schema
  import Ecto.Changeset


  schema "credentials" do
    field :email, :string
    field :password_hash, :string

    belongs_to :cooperator, ERM.Cooperators.Cooperator

    timestamps()
  end

  @doc false
  def changeset(credential, attrs) do
    IO.puts "changeset"
    credential
    |> cast(attrs, [:email])
    |> validate_required([:email])
    |> unique_constraint(:email)
  end
end
