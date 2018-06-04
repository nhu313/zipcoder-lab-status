defmodule Zipcoder.Assessments do
  @moduledoc """
  The Assessments context.
  """

  import Ecto.Query, warn: false
  alias Zipcoder.Repo

  alias Zipcoder.Assessments.Result

  alias Zipcoder.Assessments.Assessment

  @doc """
  Returns the list of assessments.

  ## Examples

      iex> list_assessments()
      [%Assessment{}, ...]

  """
  def list_assessments do
    Repo.all(Assessment)
  end

  def get_assessment_with_results(id) do
    Assessment
    |> where([a], a.id == ^id)
    |> preload([a], [results: [:student]])
    |> Repo.one
  end

  def students_without_result(assessment_id) do
    Zipcoder.Accounts.Student
    |> join(:left, [student], result in Result, result.assessment_id == ^assessment_id and result.student_id == student.id)
    |> where([_, result], is_nil(result.id))
    |> order_by([student, _], asc: student.first_name)
    |> Repo.all
  end

  @doc """
  Gets a single assessment.

  Raises `Ecto.NoResultsError` if the Assessment does not exist.

  ## Examples

      iex> get_assessment!(123)
      %Assessment{}

      iex> get_assessment!(456)
      ** (Ecto.NoResultsError)

  """
  def get_assessment!(id), do: Repo.get!(Assessment, id)

  @doc """
  Creates a assessment.

  ## Examples

      iex> create_assessment(%{field: value})
      {:ok, %Assessment{}}

      iex> create_assessment(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_assessment(attrs \\ %{}) do
    %Assessment{}
    |> Assessment.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a assessment.

  ## Examples

      iex> update_assessment(assessment, %{field: new_value})
      {:ok, %Assessment{}}

      iex> update_assessment(assessment, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_assessment(%Assessment{} = assessment, attrs) do
    assessment
    |> Assessment.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Assessment.

  ## Examples

      iex> delete_assessment(assessment)
      {:ok, %Assessment{}}

      iex> delete_assessment(assessment)
      {:error, %Ecto.Changeset{}}

  """
  def delete_assessment(%Assessment{} = assessment) do
    Repo.delete(assessment)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking assessment changes.

  ## Examples

      iex> change_assessment(assessment)
      %Ecto.Changeset{source: %Assessment{}}

  """
  def change_assessment(%Assessment{} = assessment) do
    Assessment.changeset(assessment, %{})
  end

  alias Zipcoder.Assessments.Result

  @doc """
  Returns the list of assessment_results.

  ## Examples

      iex> list_assessment_results()
      [%Result{}, ...]

  """
  def list_assessment_results do
    Repo.all(Result)
  end

  @doc """
  Gets a single result.

  Raises `Ecto.NoResultsError` if the Result does not exist.

  ## Examples

      iex> get_result!(123)
      %Result{}

      iex> get_result!(456)
      ** (Ecto.NoResultsError)

  """
  def get_result!(id), do: Repo.get!(Result, id)

  @doc """
  Creates a result.

  ## Examples

      iex> create_result(%{field: value})
      {:ok, %Result{}}

      iex> create_result(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_result(attrs \\ %{}) do
    %Result{}
    |> Result.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a result.

  ## Examples

      iex> update_result(result, %{field: new_value})
      {:ok, %Result{}}

      iex> update_result(result, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_result(%Result{} = result, attrs) do
    result
    |> Result.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Result.

  ## Examples

      iex> delete_result(result)
      {:ok, %Result{}}

      iex> delete_result(result)
      {:error, %Ecto.Changeset{}}

  """
  def delete_result(%Result{} = result) do
    Repo.delete(result)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking result changes.

  ## Examples

      iex> change_result(result)
      %Ecto.Changeset{source: %Result{}}

  """
  def change_result(%Result{} = result) do
    Result.changeset(result, %{})
  end
end
