defmodule Zipcoder.Labs.Lab do
  use Ecto.Schema
  import Ecto.Changeset


  schema "labs" do
    field :name, :string
    field :repo_name, :string

    timestamps()
  end

  @doc false
  def changeset(lab, attrs) do
    lab
    |> cast(attrs, [:name, :repo_name])
    |> validate_required([:name, :repo_name])
  end
end
