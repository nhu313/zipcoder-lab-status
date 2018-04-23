defmodule Zipcoder.Repo.Migrations.CreateLabStatuses do
  use Ecto.Migration

  def change do
    create table(:lab_statuses) do
      add :student_id, :integer
      add :lab_id, :integer
      add :status, :string
      add :url, :string
      add :original_json, :string

      timestamps()
    end

    create index(:lab_statuses, [:student_id])
    create index(:lab_statuses, [:lab_id])
  end
end
