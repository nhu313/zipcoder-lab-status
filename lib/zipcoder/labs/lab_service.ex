defmodule Zipcoder.Labs.LabService do
  alias Zipcoder.Labs

  def create_from_file(file) do
    Zipcoder.FileToDb.create_from_file(file, &to_lab/1, &Labs.create_lab/1)
  end

  defp to_lab({:ok, ["" | _]}) do
    nil
  end

  defp to_lab({:ok, [name, repo_name, order | _]}) do
    %{name: name,
      repo_name: repo_name,
      order: order}
  end

end
