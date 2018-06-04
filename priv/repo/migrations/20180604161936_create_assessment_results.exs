defmodule Zipcoder.Repo.Migrations.CreateAssessmentResults do
  use Ecto.Migration

  def change do
    create table(:assessment_results) do
      add :assessment_id, :integer
      add :student_id, :integer
      add :score, :integer

      timestamps()
    end

  end
end
