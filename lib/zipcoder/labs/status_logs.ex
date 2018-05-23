defmodule Zipcoder.Labs.StatusLogs do
  use Ecto.Schema
  import Ecto.Changeset


  schema "status_logs" do
    field :message, :map
    field :lab_status_id, :integer
    field :url, :string

    timestamps()
  end

  @doc false
  def changeset(status_logs, attrs) do
    status_logs
    |> cast(attrs, [:message, :lab_status_id, :url])
    |> validate_required([:message])
  end
end
