defmodule ZipcoderWeb.AssessmentController do
  use ZipcoderWeb, :controller

  alias Zipcoder.Assessments
  alias Zipcoder.Assessments.Assessment

  def index(conn, _params) do
    assessments = Assessments.list_assessments()
    render(conn, "index.html", assessments: assessments)
  end

  def new(conn, _params) do
    changeset = Assessments.change_assessment(%Assessment{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"assessment" => assessment_params}) do
    case Assessments.create_assessment(assessment_params) do
      {:ok, assessment} ->
        conn
        |> put_flash(:info, "Assessment created successfully.")
        |> redirect(to: assessment_path(conn, :show, assessment))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    assessment = Assessments.get_assessment!(id)
    render(conn, "show.html", assessment: assessment)
  end

  def edit(conn, %{"id" => id}) do
    assessment = Assessments.get_assessment!(id)
    changeset = Assessments.change_assessment(assessment)
    render(conn, "edit.html", assessment: assessment, changeset: changeset)
  end

  def update(conn, %{"id" => id, "assessment" => assessment_params}) do
    assessment = Assessments.get_assessment!(id)

    case Assessments.update_assessment(assessment, assessment_params) do
      {:ok, assessment} ->
        conn
        |> put_flash(:info, "Assessment updated successfully.")
        |> redirect(to: assessment_path(conn, :show, assessment))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", assessment: assessment, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    assessment = Assessments.get_assessment!(id)
    {:ok, _assessment} = Assessments.delete_assessment(assessment)

    conn
    |> put_flash(:info, "Assessment deleted successfully.")
    |> redirect(to: assessment_path(conn, :index))
  end
end
