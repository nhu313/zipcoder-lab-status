defmodule Zipcoder.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias Zipcoder.Repo

  alias Zipcoder.Accounts.Student
  alias Zipcoder.Labs


  def count_students do
    Student
    |> select([student], count(student.id))
    |> Repo.one()
  end

  @doc """
  Returns the list of students.

  ## Examples

      iex> list_students()
      [%Student{}, ...]

  """
  def list_students do
    Repo.all(Student)
  end

  def list_students_with_info do
    total_lab_count = Labs.count_labs()

    Student
    |> preload([student], [:lab_statuses])
    |> Repo.all()
    |> Enum.map(&(add_labs_completed_percent(&1, total_lab_count)))
  end

  def add_labs_completed_percent(student, 0), do: student

  def add_labs_completed_percent(student, total_lab_count) do
      %{student | labs_completed_percent: (length(student.lab_statuses)/total_lab_count) * 100}
  end

  @doc """
  Gets a single student.

  Raises `Ecto.NoResultsError` if the Student does not exist.

  ## Examples

      iex> get_student!(123)
      %Student{}

      iex> get_student!(456)
      ** (Ecto.NoResultsError)

  """
  def get_student!(id) do
    Repo.get!(Student, id)
  end

  def get_student_with_related_info!(id) do
    total_lab_count = Labs.count_labs()

    Student
    |> where([student], student.id == ^id)
    |> preload([student], [lab_statuses: [:lab, :status]])
    |> Repo.one()
    |> add_labs_completed_percent(total_lab_count)
  end

  def get_student_by_gitusername(username) do
    Repo.get_by(Student, gitusername: username)
  end

  @doc """
  Creates a student.

  ## Examples

      iex> create_student(%{field: value})
      {:ok, %Student{}}

      iex> create_student(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_student(attrs \\ %{}) do
    %Student{}
    |> Student.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a student.

  ## Examples

      iex> update_student(student, %{field: new_value})
      {:ok, %Student{}}

      iex> update_student(student, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_student(%Student{} = student, attrs) do
    student
    |> Student.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Student.

  ## Examples

      iex> delete_student(student)
      {:ok, %Student{}}

      iex> delete_student(student)
      {:error, %Ecto.Changeset{}}

  """
  def delete_student(%Student{} = student) do
    Repo.delete(student)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking student changes.

  ## Examples

      iex> change_student(student)
      %Ecto.Changeset{source: %Student{}}

  """
  def change_student(%Student{} = student) do
    Student.changeset(student, %{})
  end

end
