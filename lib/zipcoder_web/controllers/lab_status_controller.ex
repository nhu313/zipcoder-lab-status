defmodule ZipcoderWeb.LabStatusController do
  use ZipcoderWeb, :controller

  alias Zipcoder.Students
  alias Zipcoder.Students.LabStatus
  alias Zipcoder.Students.LabStatusService

  def create_hook(conn, params) do
    LabStatusService.create_and_log(params)
    text(conn, "Created!")
  end

  def create_all(conn, params) do
    Students.create_multiple_lab_statuses(params)
    redirect(conn, to: lab_path(conn, :show, params["lab_id"]))
  end

  def index(conn, _params) do
    student_lab_statuses = Students.list_student_lab_statuses()
    render(conn, "index.html", student_lab_statuses: student_lab_statuses)
  end

  def new(conn, params) do
    changeset = Students.change_lab_status(%LabStatus{student_id: params["student_id"],
                                                      lab_id: params["lab_id"],
                                                      status_id: 1})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"lab_status" => lab_status_params}) do
    case Students.create_lab_status(lab_status_params) do
      {:ok, lab_status} ->
        conn
        |> put_flash(:info, "Lab status created successfully.")
        |> redirect(to: lab_path(conn, :show, lab_status.lab_id))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    lab_status = Students.get_lab_status!(id)
    render(conn, "show.html", lab_status: lab_status)
  end

  def edit(conn, %{"id" => id}) do
    lab_status = Students.get_lab_status!(id)
    changeset = Students.change_lab_status(lab_status)
    render(conn, "edit.html", lab_status: lab_status, changeset: changeset)
  end

  def update(conn, %{"id" => id, "lab_status" => lab_status_params}) do
    lab_status = Students.get_lab_status!(id)

    case Students.update_lab_status(lab_status, lab_status_params) do
      {:ok, lab_status} ->
        conn
        |> put_flash(:info, "Lab status updated successfully.")
        |> redirect(to: lab_status_path(conn, :show, lab_status))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", lab_status: lab_status, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    lab_status = Students.get_lab_status!(id)
    {:ok, _lab_status} = Students.delete_lab_status(lab_status)

    conn
    |> put_flash(:info, "Lab status deleted successfully.")
    |> redirect(to: student_path(conn, :show, lab_status.student_id))
  end
end
