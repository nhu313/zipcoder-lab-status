defmodule ZipcoderWeb.StudentController do
  use ZipcoderWeb, :controller

  alias Zipcoder.Accounts
  alias Zipcoder.Accounts.Student
  alias Zipcoder.Accounts.StudentService
  alias Zipcoder.Labs
  alias Zipcoder.Assessments.Result

  def create_all(conn,  %{"file" => file}) do
    StudentService.create_from_file(file)
    redirect(conn, to: student_path(conn, :index))
  end

  def index(conn, _params) do
    assessments = Zipcoder.Assessments.list_assessments()
    students = Accounts.list_students_with_info() |> Enum.map(&(map_results(&1, assessments)))
    render(conn, "index.html", students: students, assessments: assessments)
  end

  def map_results(student, assessments) do
    results = student.assessment_results
    sorted_results = assessments
                      |> IO.inspect
                      |> Enum.map(&(%Result{score: find_score(&1, results), assessment: &1, student: student}))
                      |> IO.inspect

    Map.put(student, :assessment_results, sorted_results)
  end

  def find_score(assessment, results) do
    result = Enum.find(results, &(&1.assessment_id == assessment.id))
    if result do
      result.score
    else
      0
    end
  end

  def new(conn, _params) do
    changeset = Accounts.change_student(%Student{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"student" => student_params}) do
    case Accounts.create_student(student_params) do
      {:ok, student} ->
        conn
        |> put_flash(:info, "Student created successfully.")
        |> redirect(to: student_path(conn, :show, student))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    student = Accounts.get_student_with_related_info!(id)
    render(conn, "show.html", student: student, labs_without_pr: Labs.labs_without_pr(student))
  end

  def edit(conn, %{"id" => id}) do
    student = Accounts.get_student!(id)
    changeset = Accounts.change_student(student)
    render(conn, "edit.html", student: student, changeset: changeset)
  end

  def update(conn, %{"id" => id, "student" => student_params}) do
    student = Accounts.get_student!(id)

    case Accounts.update_student(student, student_params) do
      {:ok, student} ->
        conn
        |> put_flash(:info, "Student updated successfully.")
        |> redirect(to: student_path(conn, :show, student))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", student: student, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    student = Accounts.get_student!(id)
    {:ok, _student} = Accounts.delete_student(student)

    conn
    |> put_flash(:info, "Student deleted successfully.")
    |> redirect(to: student_path(conn, :index))
  end
end
