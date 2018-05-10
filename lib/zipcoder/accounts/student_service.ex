defmodule Zipcoder.Accounts.StudentService do
  alias Zipcoder.Accounts

  def create_from_file(file) do
    Zipcoder.FileToDb.create_from_file(file, &to_student/1, &Accounts.create_student/1)
  end

  defp to_student({:ok, ["" | _]}) do
    nil
  end

  defp to_student({:ok, [first_name, last_name, gitusername | _]}) do
    %{first_name: first_name,
      last_name: last_name,
      gitusername: String.downcase(gitusername)}
  end

end
