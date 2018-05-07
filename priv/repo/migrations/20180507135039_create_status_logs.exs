defmodule Zipcoder.Repo.Migrations.CreateStatusLogs do
  use Ecto.Migration

  def change do
    create table(:status_logs) do
      add :message, :string, size: 7000
      add :student_lab_status_id, :integer

      timestamps()
    end

    alter table(:student_lab_statuses) do
      remove :original_json
    end
  end
end
