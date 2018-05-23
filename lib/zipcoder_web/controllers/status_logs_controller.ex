defmodule ZipcoderWeb.StatusLogsController do
  use ZipcoderWeb, :controller

  alias Zipcoder.Labs
  alias Zipcoder.Labs.StatusLogs
  alias Zipcoder.Students.LabStatusService

  def index(conn, _params) do
    status_logs = Labs.list_status_logs()
    render(conn, "index.html", status_logs: status_logs)
  end

  def new(conn, _params) do
    changeset = Labs.change_status_logs(%StatusLogs{})
    render(conn, "new.html", changeset: changeset)
  end

  def process(conn, %{"id" => id}) do
    status_log = Labs.get_status_logs!(id)
    case LabStatusService.create(Poison.decode!(status_log.message)) do
      {:ok, status} ->
        redirect(conn, to: student_path(conn, :show, status.student_id))
      _ ->
        redirect(conn, to: status_logs_path(conn, :index))
    end
  end

  def create(conn, %{"status_logs" => status_logs_params}) do
    case Labs.create_status_logs(status_logs_params) do
      {:ok, status_logs} ->
        conn
        |> put_flash(:info, "Status logs created successfully.")
        |> redirect(to: status_logs_path(conn, :show, status_logs))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    status_logs = Labs.get_status_logs!(id)
    render(conn, "show.html", status_logs: status_logs)
  end

  def edit(conn, %{"id" => id}) do
    status_logs = Labs.get_status_logs!(id)
    changeset = Labs.change_status_logs(status_logs)
    render(conn, "edit.html", status_logs: status_logs, changeset: changeset)
  end

  def update(conn, %{"id" => id, "status_logs" => status_logs_params}) do
    status_logs = Labs.get_status_logs!(id)

    case Labs.update_status_logs(status_logs, status_logs_params) do
      {:ok, status_logs} ->
        conn
        |> put_flash(:info, "Status logs updated successfully.")
        |> redirect(to: status_logs_path(conn, :show, status_logs))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", status_logs: status_logs, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    status_logs = Labs.get_status_logs!(id)
    {:ok, _status_logs} = Labs.delete_status_logs(status_logs)

    conn
    |> put_flash(:info, "Status logs deleted successfully.")
    |> redirect(to: status_logs_path(conn, :index))
  end
end
