defmodule Zipcoder.Repo.Migrations.CreateLabs do
  use Ecto.Migration

  def change do
    create table(:labs) do
      add :name, :string
      add :repo_name, :string

      timestamps()
    end

  end
end
