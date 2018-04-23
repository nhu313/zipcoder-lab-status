defmodule Zipcoder.Accounts.StudentService do
  alias Zipcoder.Accounts

  def create_all(file) do
    file
    |> parse_file
    |> Enum.map(&Accounts.create_student/1)
  end

  def parse_file(file) do
    file.path
    |> File.stream!
    |> CSV.decode
    |> Stream.drop(1)
    |> Stream.map(&to_student/1)
    |> Stream.reject(&(&1 == nil))
    |> Enum.to_list()
  end

  defp to_student({:ok, ["" | _]}) do
    nil
  end

  defp to_student({:ok, [first_name, last_name, gitusername | _]}) do
    %{first_name: first_name,
      last_name: last_name,
      gitusername: gitusername}
  end

end
