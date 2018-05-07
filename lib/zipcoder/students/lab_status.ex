defmodule Zipcoder.Students.LabStatus do
  use Ecto.Schema
  import Ecto.Changeset


  schema "student_lab_statuses" do
    field :lab_id, :integer
    field :student_id, :integer
    field :status_id, :integer
    field :url, :string

    timestamps()
  end

  @doc false
  def changeset(lab_status, attrs) do
    lab_status
    |> cast(attrs, [:student_id, :lab_id, :status_id, :url])
    |> validate_required([:student_id, :lab_id])
  end
end
