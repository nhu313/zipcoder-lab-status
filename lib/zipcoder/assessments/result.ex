defmodule Zipcoder.Assessments.Result do
  use Ecto.Schema
  import Ecto.Changeset


  schema "assessment_results" do
    field :assessment_id, :integer
    field :score, :integer
    field :student_id, :integer
    field :notes, :string

    timestamps()
  end

  @doc false
  def changeset(result, attrs) do
    result
    |> cast(attrs, [:assessment_id, :student_id, :score, :notes])
    |> validate_required([:assessment_id, :student_id, :score])
  end
end
