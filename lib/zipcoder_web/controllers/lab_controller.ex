defmodule ZipcoderWeb.LabController do
  use ZipcoderWeb, :controller

  alias Zipcoder.Labs
  alias Zipcoder.Labs.Lab
  alias Zipcoder.Labs.LabService

  def index(conn, _params) do
    labs = Labs.labs_with_students()
    render(conn, "index.html", labs: labs)
  end

  def create_all(conn,  %{"file" => file}) do
    LabService.create_from_file(file)
    redirect(conn, to: lab_path(conn, :index))
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
    lab = Labs.get_lab_with_students(id)
    students_without_pr = lab
                          |> Labs.students_without_pr_for_lab
                          |> Enum.map(&({"#{&1.first_name } (#{&1.gitusername})", &1.id}))
    # so total would never be 0. don't judge my hackiness. it's a throwaway project
    total = length(lab.lab_statuses) + length(students_without_pr) + 0.000001

    render(conn, "show.html", lab: lab,
                              students_without_pr: students_without_pr,
                              percent_completed: length(lab.lab_statuses)/total)
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
