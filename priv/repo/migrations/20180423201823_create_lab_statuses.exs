defmodule Zipcoder.Repo.Migrations.CreateLabStatuses do
  use Ecto.Migration

  def change do
    create table(:lab_statuses) do
      add :name, :string

      timestamps()
    end

  end
end
