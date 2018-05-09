defmodule Zipcoder.Students.LabStatus do
  use Ecto.Schema
  import Ecto.Changeset
  alias Zipcoder.Labs.Lab
  alias Zipcoder.Labs.Status
  alias Zipcoder.Accounts.Student

  schema "student_lab_statuses" do
    field :url, :string

    belongs_to :lab, Lab
    belongs_to :status, Status
    belongs_to :student, Student

    timestamps()
  end

  @doc false
  def changeset(lab_status, attrs) do
    lab_status
    |> cast(attrs, [:student_id, :lab_id, :status_id, :url])
    |> validate_required([:student_id, :lab_id])
  end
end
