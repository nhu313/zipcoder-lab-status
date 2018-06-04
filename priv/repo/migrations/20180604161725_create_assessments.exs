defmodule Zipcoder.Repo.Migrations.CreateAssessments do
  use Ecto.Migration

  def change do
    create table(:assessments) do
      add :name, :string
      add :max_score, :integer
      add :passing_score, :integer
      add :type, :string

      timestamps()
    end

  end
end
