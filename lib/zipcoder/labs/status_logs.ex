defmodule Zipcoder.Labs.StatusLogs do
  use Ecto.Schema
  import Ecto.Changeset


  schema "status_logs" do
    field :message, :string
    field :student_lab_status_id, :integer

    timestamps()
  end

  @doc false
  def changeset(status_logs, attrs) do
    status_logs
    |> cast(attrs, [:message, :student_lab_status_id])
    |> validate_required([:message])
  end
end
