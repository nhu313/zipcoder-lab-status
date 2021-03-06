defmodule ZipcoderWeb.ResultController do
  use ZipcoderWeb, :controller

  alias Zipcoder.Assessments
  alias Zipcoder.Assessments.Result

  def index(conn, _params) do
    assessment_results = Assessments.list_assessment_results()
    render(conn, "index.html", assessment_results: assessment_results)
  end

  def new(conn, params) do
    assessments = Assessments.list_assessments() |> map_for_select
    students = Zipcoder.Accounts.list_students() |> map_students_for_select
    changeset = Assessments.change_result(%Result{assessment_id: params["assessment_id"], student_id: params["student_id"]})
    render(conn, "new.html", changeset: changeset, assessments: assessments, students: students)
  end

  def map_students_for_select(students) do
    Enum.map(students, &{&1.first_name <> " " <> &1.last_name, &1.id})
  end

  def map_for_select(models) do
    Enum.map(models, &{&1.name, &1.id})
  end

  def create(conn, %{"result" => result_params}) do
    case Assessments.create_result(result_params) do
      {:ok, result} ->
        conn
        |> put_flash(:info, "Result created successfully.")
        |> redirect(to: assessment_path(conn, :show, result.assessment_id))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    result = Assessments.get_result!(id)
    render(conn, "show.html", result: result)
  end

  def edit(conn, %{"id" => id}) do
    assessments = Assessments.list_assessments() |> map_for_select
    students = Zipcoder.Accounts.list_students() |> map_students_for_select
    result = Assessments.get_result!(id)
    changeset = Assessments.change_result(result)
    render(conn, "edit.html", result: result, changeset: changeset, assessments: assessments, students: students)
  end

  def update(conn, %{"id" => id, "result" => result_params}) do
    result = Assessments.get_result!(id)

    case Assessments.update_result(result, result_params) do
      {:ok, result} ->
        conn
        |> put_flash(:info, "Result updated successfully.")
        |> redirect(to: result_path(conn, :show, result))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", result: result, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    result = Assessments.get_result!(id)
    {:ok, _result} = Assessments.delete_result(result)

    conn
    |> put_flash(:info, "Result deleted successfully.")
    |> redirect(to: result_path(conn, :index))
  end
end
