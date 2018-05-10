defmodule Zipcoder.Labs.Lab do
  use Ecto.Schema
  import Ecto.Changeset

  alias Zipcoder.Students.LabStatus

  schema "labs" do
    field :name, :string
    field :repo_name, :string
    field :percent_completed, :integer, virtual: true, default: 0
    field :order, :integer

    has_many :lab_statuses, LabStatus

    timestamps()
  end

  @doc false
  def changeset(lab, attrs) do
    lab
    |> cast(attrs, [:name, :repo_name, :order])
    |> validate_required([:name, :repo_name])
  end
end
