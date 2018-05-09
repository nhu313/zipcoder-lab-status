defmodule Zipcoder.Accounts.Student do
  use Ecto.Schema
  import Ecto.Changeset


  schema "students" do
    field :first_name, :string
    field :gitusername, :string
    field :last_name, :string
    field :labs_completed_percent, :integer, virtual: true, default: 0

    has_many :lab_statuses, Zipcoder.Students.LabStatus, on_delete: :delete_all

    timestamps()
  end

  @doc false
  def changeset(student, attrs) do
    student
    |> cast(attrs, [:first_name, :last_name, :gitusername])
    |> validate_required([:first_name, :last_name, :gitusername])
  end
end
