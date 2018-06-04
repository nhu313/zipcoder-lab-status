defmodule Zipcoder.Assessments.Result do
  use Ecto.Schema
  import Ecto.Changeset


  schema "assessment_results" do
    field :score, :integer
    field :notes, :string

    belongs_to :student, Zipcoder.Accounts.Student
    belongs_to :assessment, Zipcoder.Assessments.Assessment

    timestamps()
  end

  @doc false
  def changeset(result, attrs) do
    result
    |> cast(attrs, [:assessment_id, :student_id, :score, :notes])
    |> validate_required([:assessment_id, :student_id, :score])
  end
end
