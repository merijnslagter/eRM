defmodule ERM.Cooperation do
  @moduledoc """
  The Cooperation context.
  """

  import Ecto.Query, warn: false
  alias ERM.Repo

  alias ERM.Cooperation.EI

  @doc """
  Returns the list of e2s.

  ## Examples

      iex> list_e2s()
      [%E2{}, ...]

  """
  def list_e2s do
    Repo.all(EI)
  end

  def list_farms do
    EI
    |> where([u], u.type == "FARM")
    |> Repo.all()
  end

  def list_measurements_for_farm(farm) do
    EI
    |> where([f], f.geom == ^farm.geom)
    |> Repo.all()
  end

  @doc """
  Gets a single e2.

  Raises `Ecto.NoResultsError` if the E2 does not exist.

  ## Examples

      iex> get_e2!(123)
      %E2{}

      iex> get_e2!(456)
      ** (Ecto.NoResultsError)

  """
  def get_e2!(id), do: Repo.get!(EI, id)

  def create_e2(%{"ei_id" => ei_id, "type" => "MEASUREMENT" = type, "relation" => relation} = attrs) do
    #IO.puts "create_e2: #{ei_id} of type: relation #{relation} #{type}"
    IO.puts "create_e2: #{ei_id} of type #{type}"
    #"relation" => relation,
    IO.inspect attrs
    parent_e3 = get_e2!(ei_id)

    # update attrs: geom
    # create geom =
    now = DateTime.utc_now()
    geo = parent_e3.geom
    # create multi
    # create_e3
    # get_related_e3(attrs["ei_id"])
    # create relation hash |> relation |>
    #

    %EI{geom: geo, date: now}
    |> EI.create_changeset(attrs)
    |> IO.inspect()
    |> Repo.insert()
    #|> create_related(parent_e3, relation)
    # |> create_relation(relation)
  end

  def create_related({:ok, _e3}, _parent, _relation) do
    {:ok, :relation_created}
  end

  def create_related(pass, _parent, _relation) do
    pass
  end


  @doc """
  Creates a e2.

  ## Examples

      iex> create_e2(%{field: value})
      {:ok, %E2{}}

      iex> create_e2(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_e2(attrs \\ %{}) do
    IO.puts "create_e2"
    IO.inspect attrs

    # update attrs: geom
    # create geom =
    now = DateTime.utc_now()
    geo = %Geo.Point{coordinates: {attrs["lat"], attrs["long"]}, srid: 4326}
    # create multi
    # create_e3
    # get_related_e3(attrs["ei_id"])
    # create relation hash |> relation |>
    #

    %EI{geom: geo, date: now}
    |> EI.create_changeset(attrs)
    |> IO.inspect()
    |> Repo.insert()
  end

  @doc """
  Updates a e2.

  ## Examples

      iex> update_e2(e2, %{field: new_value})
      {:ok, %E2{}}

      iex> update_e2(e2, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_e2(%EI{} = e2, attrs) do
    e2
    |> EI.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a E2.

  ## Examples

      iex> delete_e2(e2)
      {:ok, %E2{}}

      iex> delete_e2(e2)
      {:error, %Ecto.Changeset{}}

  """
  def delete_e2(%EI{} = e2) do
    Repo.delete(e2)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking e2 changes.

  ## Examples

      iex> change_e2(e2)
      %Ecto.Changeset{source: %E2{}}

  """
  def change_e2(%EI{} = e2) do
    EI.changeset(e2, %{})
  end
end
