defmodule Zipcoder.Assessments.Assessment do
  use Ecto.Schema
  import Ecto.Changeset


  schema "assessments" do
    field :max_score, :integer
    field :name, :string
    field :passing_score, :integer
    field :type, :string

    timestamps()
  end

  @doc false
  def changeset(assessment, attrs) do
    assessment
    |> cast(attrs, [:name, :max_score, :passing_score, :type])
    |> validate_required([:name, :max_score, :passing_score, :type])
  end
end
