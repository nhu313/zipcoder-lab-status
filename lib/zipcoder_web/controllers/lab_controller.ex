defmodule ZipcoderWeb.LabController do
  use ZipcoderWeb, :controller

  alias Zipcoder.Labs
  alias Zipcoder.Labs.Lab

  def index(conn, _params) do
    labs = Labs.list_labs()
    render(conn, "index.html", labs: labs)
  end

  def new(conn, _params) do
    changeset = Labs.change_lab(%Lab{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"lab" => lab_params}) do
    case Labs.create_lab(lab_params) do
      {:ok, lab} ->
        conn
        |> put_flash(:info, "Lab created successfully.")
        |> redirect(to: lab_path(conn, :show, lab))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    lab = Labs.get_lab!(id)
    render(conn, "show.html", lab: lab)
  end

  def edit(conn, %{"id" => id}) do
    lab = Labs.get_lab!(id)
    changeset = Labs.change_lab(lab)
    render(conn, "edit.html", lab: lab, changeset: changeset)
  end

  def update(conn, %{"id" => id, "lab" => lab_params}) do
    lab = Labs.get_lab!(id)

    case Labs.update_lab(lab, lab_params) do
      {:ok, lab} ->
        conn
        |> put_flash(:info, "Lab updated successfully.")
        |> redirect(to: lab_path(conn, :show, lab))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", lab: lab, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    lab = Labs.get_lab!(id)
    {:ok, _lab} = Labs.delete_lab(lab)

    conn
    |> put_flash(:info, "Lab deleted successfully.")
    |> redirect(to: lab_path(conn, :index))
  end
end
