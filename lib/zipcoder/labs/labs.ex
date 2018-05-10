defmodule Zipcoder.Labs do
  @moduledoc """
  The Labs context.
  """

  import Ecto.Query, warn: false
  alias Zipcoder.Repo

  alias Zipcoder.Labs.Lab
  alias Zipcoder.Students.LabStatus
  alias Zipcoder.Accounts.Student
  alias Zipcoder.Accounts

  @doc """
  Returns the list of labs.

  ## Examples

      iex> list_labs()
      [%Lab{}, ...]

  """
  def list_labs do
    Repo.all(Lab)
  end

  def labs_with_students do
    total_student_count = Accounts.count_students()

    Lab
    |> preload([lab], [:lab_statuses])
    |> order_by([lab], asc: lab.order, asc: lab.inserted_at)
    |> Repo.all()
    |> Enum.map(&(add_students_completed_percent(&1, total_student_count)))
  end

  defp add_students_completed_percent(lab, 0), do: lab
  defp add_students_completed_percent(lab, total_student_count) do
    %{lab | percent_completed: (length(lab.lab_statuses)/total_student_count)}
  end

  def count_labs do
    Lab
    |> select([lab], count(lab.id))
    |> Repo.one()
  end

  def labs_without_pr(%Student{id: student_id}) do
    Lab
    |> join(:left, [lab], lab_status in LabStatus, lab.id == lab_status.lab_id and lab_status.student_id == ^student_id)
    |> where([_, lab_status], is_nil(lab_status.id))
    |> Repo.all
  end
  @doc """
  Gets a single lab.

  Raises `Ecto.NoResultsError` if the Lab does not exist.

  ## Examples

      iex> get_lab!(123)
      %Lab{}

      iex> get_lab!(456)
      ** (Ecto.NoResultsError)

  """
  def get_lab!(id), do: Repo.get!(Lab, id)
  def get_lab_with_students(id) do
    Lab
    |> where([lab], lab.id == ^id)
    |> preload([lab], [lab_statuses: [:student]])
    |> Repo.one
  end

  def get_lab_by_repo_name(repo_name), do: Repo.get_by(Lab, repo_name: repo_name)


  def students_without_pr_for_lab(%{id: lab_id}) do
    Student
    |> join(:left, [student], lab_status in LabStatus, lab_status.lab_id == ^lab_id and lab_status.student_id == student.id)
    |> where([_, lab_status], is_nil(lab_status.id))
    |> Repo.all
  end

  @doc """
  Creates a lab.

  ## Examples

      iex> create_lab(%{field: value})
      {:ok, %Lab{}}

      iex> create_lab(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_lab(attrs \\ %{}) do
    %Lab{}
    |> Lab.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a lab.

  ## Examples

      iex> update_lab(lab, %{field: new_value})
      {:ok, %Lab{}}

      iex> update_lab(lab, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_lab(%Lab{} = lab, attrs) do
    lab
    |> Lab.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Lab.

  ## Examples

      iex> delete_lab(lab)
      {:ok, %Lab{}}

      iex> delete_lab(lab)
      {:error, %Ecto.Changeset{}}

  """
  def delete_lab(%Lab{} = lab) do
    Repo.delete(lab)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking lab changes.

  ## Examples

      iex> change_lab(lab)
      %Ecto.Changeset{source: %Lab{}}

  """
  def change_lab(%Lab{} = lab) do
    Lab.changeset(lab, %{})
  end

  alias Zipcoder.Labs.Status

  @doc """
  Returns the list of lab_statuses.

  ## Examples

      iex> list_lab_statuses()
      [%Status{}, ...]

  """
  def list_lab_statuses do
    Repo.all(Status)
  end

  @doc """
  Gets a single status.

  Raises `Ecto.NoResultsError` if the Status does not exist.

  ## Examples

      iex> get_status!(123)
      %Status{}

      iex> get_status!(456)
      ** (Ecto.NoResultsError)

  """
  def get_status!(id), do: Repo.get!(Status, id)
  def get_status_by_name(name), do: Repo.get_by(Status, name: name)

  @doc """
  Creates a status.

  ## Examples

      iex> create_status(%{field: value})
      {:ok, %Status{}}

      iex> create_status(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_status(attrs \\ %{}) do
    %Status{}
    |> Status.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a status.

  ## Examples

      iex> update_status(status, %{field: new_value})
      {:ok, %Status{}}

      iex> update_status(status, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_status(%Status{} = status, attrs) do
    status
    |> Status.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Status.

  ## Examples

      iex> delete_status(status)
      {:ok, %Status{}}

      iex> delete_status(status)
      {:error, %Ecto.Changeset{}}

  """
  def delete_status(%Status{} = status) do
    Repo.delete(status)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking status changes.

  ## Examples

      iex> change_status(status)
      %Ecto.Changeset{source: %Status{}}

  """
  def change_status(%Status{} = status) do
    Status.changeset(status, %{})
  end

  alias Zipcoder.Labs.StatusLogs

  @doc """
  Returns the list of status_logs.

  ## Examples

      iex> list_status_logs()
      [%StatusLogs{}, ...]

  """
  def list_status_logs do
    Repo.all(StatusLogs)
  end

  @doc """
  Gets a single status_logs.

  Raises `Ecto.NoResultsError` if the Status logs does not exist.

  ## Examples

      iex> get_status_logs!(123)
      %StatusLogs{}

      iex> get_status_logs!(456)
      ** (Ecto.NoResultsError)

  """
  def get_status_logs!(id), do: Repo.get!(StatusLogs, id)

  @doc """
  Creates a status_logs.

  ## Examples

      iex> create_status_logs(%{field: value})
      {:ok, %StatusLogs{}}

      iex> create_status_logs(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_status_logs(attrs \\ %{}) do
    %StatusLogs{}
    |> StatusLogs.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a status_logs.

  ## Examples

      iex> update_status_logs(status_logs, %{field: new_value})
      {:ok, %StatusLogs{}}

      iex> update_status_logs(status_logs, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_status_logs(%StatusLogs{} = status_logs, attrs) do
    status_logs
    |> StatusLogs.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a StatusLogs.

  ## Examples

      iex> delete_status_logs(status_logs)
      {:ok, %StatusLogs{}}

      iex> delete_status_logs(status_logs)
      {:error, %Ecto.Changeset{}}

  """
  def delete_status_logs(%StatusLogs{} = status_logs) do
    Repo.delete(status_logs)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking status_logs changes.

  ## Examples

      iex> change_status_logs(status_logs)
      %Ecto.Changeset{source: %StatusLogs{}}

  """
  def change_status_logs(%StatusLogs{} = status_logs) do
    StatusLogs.changeset(status_logs, %{})
  end
end
