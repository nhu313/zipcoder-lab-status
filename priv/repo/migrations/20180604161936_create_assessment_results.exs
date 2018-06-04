defmodule Zipcoder.Repo.Migrations.CreateAssessmentResults do
  use Ecto.Migration

  def change do
    create table(:assessment_results) do
      add :assessment_id, :integer
      add :student_id, :integer
      add :score, :integer
      add :notes, :string, size: 3000

      timestamps()
    end

  end
end
