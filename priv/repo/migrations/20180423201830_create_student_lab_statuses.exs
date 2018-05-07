defmodule Zipcoder.Repo.Migrations.CreateStudentLabStatuses do
  use Ecto.Migration

  def change do
    create table(:student_lab_statuses) do
      add :student_id, :integer
      add :lab_id, :integer
      add :status_id, :integer
      add :url, :string
      add :original_json, :string

      timestamps()
    end

    create index(:student_lab_statuses, [:student_id])
    create index(:student_lab_statuses, [:lab_id])
    create index(:student_lab_statuses, [:status_id])
  end
end
