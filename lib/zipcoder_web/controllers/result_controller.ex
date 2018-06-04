defmodule ZipcoderWeb.ResultController do
  use ZipcoderWeb, :controller

  alias Zipcoder.Assessments
  alias Zipcoder.Assessments.Result

  def index(conn, _params) do
    assessment_results = Assessments.list_assessment_results()
    render(conn, "index.html", assessment_results: assessment_results)
  end

  def new(conn, _params) do
    changeset = Assessments.change_result(%Result{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"result" => result_params}) do
    case Assessments.create_result(result_params) do
      {:ok, result} ->
        conn
        |> put_flash(:info, "Result created successfully.")
        |> redirect(to: result_path(conn, :show, result))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    result = Assessments.get_result!(id)
    render(conn, "show.html", result: result)
  end

  def edit(conn, %{"id" => id}) do
    result = Assessments.get_result!(id)
    changeset = Assessments.change_result(result)
    render(conn, "edit.html", result: result, changeset: changeset)
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
