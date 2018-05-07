defmodule ZipcoderWeb.StatusController do
  use ZipcoderWeb, :controller

  alias Zipcoder.Labs
  alias Zipcoder.Labs.Status

  def index(conn, _params) do
    lab_statuses = Labs.list_lab_statuses()
    render(conn, "index.html", lab_statuses: lab_statuses)
  end

  def new(conn, _params) do
    changeset = Labs.change_status(%Status{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"status" => status_params}) do
    case Labs.create_status(status_params) do
      {:ok, status} ->
        conn
        |> put_flash(:info, "Status created successfully.")
        |> redirect(to: status_path(conn, :show, status))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    status = Labs.get_status!(id)
    render(conn, "show.html", status: status)
  end

  def edit(conn, %{"id" => id}) do
    status = Labs.get_status!(id)
    changeset = Labs.change_status(status)
    render(conn, "edit.html", status: status, changeset: changeset)
  end

  def update(conn, %{"id" => id, "status" => status_params}) do
    status = Labs.get_status!(id)

    case Labs.update_status(status, status_params) do
      {:ok, status} ->
        conn
        |> put_flash(:info, "Status updated successfully.")
        |> redirect(to: status_path(conn, :show, status))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", status: status, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    status = Labs.get_status!(id)
    {:ok, _status} = Labs.delete_status(status)

    conn
    |> put_flash(:info, "Status deleted successfully.")
    |> redirect(to: status_path(conn, :index))
  end
end
