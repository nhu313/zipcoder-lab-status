defmodule Zipcoder.Repo.Migrations.CreateStatusLogs do
  use Ecto.Migration

  def up do
    create table(:status_logs) do
      add :message, :string, size: 7000
      add :lab_status_id, :integer
      add :url, :string

      timestamps()
    end

    alter table(:student_lab_statuses) do
      remove :original_json
    end
  end

  def down do
    drop table(:status_logs)

    alter table(:student_lab_statuses) do
      add :original_json, :string, size: 7000
    end
  end
end
