defmodule Zipcoder.Repo.Migrations.AddOrderToLab do
  use Ecto.Migration

  def change do
    alter table(:labs) do
      add :order, :integer
    end
  end
end
