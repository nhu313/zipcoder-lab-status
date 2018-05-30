defmodule Zipcoder.Students do
  @moduledoc """
  The Students context.
  """

  import Ecto.Query, warn: false
  alias Zipcoder.Repo

  alias Zipcoder.Students.LabStatus

  @doc """
  Returns the list of student_lab_statuses.

  ## Examples

      iex> list_student_lab_statuses()
      [%LabStatus{}, ...]

  """
  def list_student_lab_statuses do
    LabStatus
    |> order_by([s], asc: s.student_id, asc: s.lab_id)
    |> Repo.all()
  end

  @doc """
  Gets a single lab_status.

  Raises `Ecto.NoResultsError` if the Lab status does not exist.

  ## Examples

      iex> get_lab_status!(123)
      %LabStatus{}

      iex> get_lab_status!(456)
      ** (Ecto.NoResultsError)

  """
  def get_lab_status!(id), do: Repo.get!(LabStatus, id)

  @doc """
  Creates a lab_status.

  ## Examples

      iex> create_lab_status(%{field: value})
      {:ok, %LabStatus{}}

      iex> create_lab_status(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_lab_status(attrs \\ %{}) do
    %LabStatus{}
    |> LabStatus.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a lab_status.

  ## Examples

      iex> update_lab_status(lab_status, %{field: new_value})
      {:ok, %LabStatus{}}

      iex> update_lab_status(lab_status, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_lab_status(%LabStatus{} = lab_status, attrs) do
    lab_status
    |> LabStatus.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a LabStatus.

  ## Examples

      iex> delete_lab_status(lab_status)
      {:ok, %LabStatus{}}

      iex> delete_lab_status(lab_status)
      {:error, %Ecto.Changeset{}}

  """
  def delete_lab_status(%LabStatus{} = lab_status) do
    Repo.delete(lab_status)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking lab_status changes.

  ## Examples

      iex> change_lab_status(lab_status)
      %Ecto.Changeset{source: %LabStatus{}}

  """
  def change_lab_status(%LabStatus{} = lab_status) do
    LabStatus.changeset(lab_status, %{})
  end
end
