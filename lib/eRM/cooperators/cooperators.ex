defmodule ERM.Cooperators do
  @moduledoc """
  The Cooperators context.
  """

  import Ecto.Query, warn: false
  alias ERM.Repo

  alias ERM.Cooperators.Cooperator
  alias ERM.Cooperators.Credential

  @doc """
  Returns the list of cooperators.

  ## Examples

      iex> list_cooperators()
      [%Cooperator{}, ...]

  """
  def list_cooperators do
    Repo.all(Cooperator)
    |> Repo.preload(:credential)
  end

  @doc """
  Gets a single cooperator.

  Raises `Ecto.NoResultsError` if the Cooperator does not exist.

  ## Examples

      iex> get_cooperator!(123)
      %Cooperator{}

      iex> get_cooperator!(456)
      ** (Ecto.NoResultsError)

  """
  def get_cooperator!(id) do
    Repo.get!(Cooperator, id)
    |> Repo.preload(:credential)
    |> IO.inspect()
  end

  @doc """
  Creates a cooperator.

  ## Examples

      iex> create_cooperator(%{field: value})
      {:ok, %Cooperator{}}

      iex> create_cooperator(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_cooperator(attrs \\ %{}) do
    #create keys
    #{pub, priv} = ERM.Cooperators.KeyPair.create_keypair()
    %Cooperator{}
    |> Cooperator.changeset(attrs)
    |> Ecto.Changeset.cast_assoc(:credential, with: &Credential.changeset/2)
    |> generate_keypair()
    |> Repo.insert()
  end

  def generate_keypair(changeset) do
    {pub, priv} = ERM.Cooperators.KeyPair.create_keypair()
    changeset
    |> Ecto.Changeset.put_change(:priv_key, Base.encode16(priv))
    |> Ecto.Changeset.put_change(:pub_key, Base.encode16(pub))
  end

  @doc """
  Updates a cooperator.

  ## Examples

      iex> update_cooperator(cooperator, %{field: new_value})
      {:ok, %Cooperator{}}

      iex> update_cooperator(cooperator, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_cooperator(%Cooperator{} = cooperator, attrs) do
    cooperator
    |> Cooperator.changeset(attrs)
    |> Ecto.Changeset.cast_assoc(:credential, with: &Credential.changeset/2)
    |> Repo.update()
  end

  @doc """
  Deletes a Cooperator.

  ## Examples

      iex> delete_cooperator(cooperator)
      {:ok, %Cooperator{}}

      iex> delete_cooperator(cooperator)
      {:error, %Ecto.Changeset{}}

  """
  def delete_cooperator(%Cooperator{} = cooperator) do
    Repo.delete(cooperator)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking cooperator changes.

  ## Examples

      iex> change_cooperator(cooperator)
      %Ecto.Changeset{source: %Cooperator{}}

  """
  def change_cooperator(%Cooperator{} = cooperator) do
    Cooperator.changeset(cooperator, %{})
  end

  @doc """
  Returns the list of credentials.

  ## Examples

      iex> list_credentials()
      [%Credential{}, ...]

  """
  def list_credentials do
    Repo.all(Credential)
  end

  @doc """
  Gets a single credential.

  Raises `Ecto.NoResultsError` if the Credential does not exist.

  ## Examples

      iex> get_credential!(123)
      %Credential{}

      iex> get_credential!(456)
      ** (Ecto.NoResultsError)

  """
  def get_credential!(id), do: Repo.get!(Credential, id)

  @doc """
  Creates a credential.

  ## Examples

      iex> create_credential(%{field: value})
      {:ok, %Credential{}}

      iex> create_credential(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_credential(attrs \\ %{}) do
    %Credential{}
    |> Credential.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a credential.

  ## Examples

      iex> update_credential(credential, %{field: new_value})
      {:ok, %Credential{}}

      iex> update_credential(credential, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_credential(%Credential{} = credential, attrs) do
    credential
    |> Credential.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Credential.

  ## Examples

      iex> delete_credential(credential)
      {:ok, %Credential{}}

      iex> delete_credential(credential)
      {:error, %Ecto.Changeset{}}

  """
  def delete_credential(%Credential{} = credential) do
    Repo.delete(credential)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking credential changes.

  ## Examples

      iex> change_credential(credential)
      %Ecto.Changeset{source: %Credential{}}

  """
  def change_credential(%Credential{} = credential) do
    Credential.changeset(credential, %{})
  end

  def authenticate_by_email_password(email, _password) do
    IO.puts "doing auh"
    IO.inspect email
    query =
      from co in Cooperator,
        inner_join: cr in assoc(co, :credential),
        where: cr.email == ^email

    case Repo.one(query) do
      %Cooperator{} = cooperator -> {:ok, cooperator}
      nil -> {:error, :unauthorized}
      |> IO.inspect()
    end
  end
end
