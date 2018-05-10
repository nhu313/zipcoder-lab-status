defmodule Zipcoder.FileToDbTest do
  use Zipcoder.DataCase

  describe "create_all" do
    alias Zipcoder.FileToDb
    alias Zipcoder.Accounts

    test "create_students" do
      FileToDb.create_from_file(get_file_path(), &parse_func/1,  &Accounts.create_student/1)

      assert Accounts.count_students() == 2
    end

    test "parse file" do
      results = FileToDb.parse_file(get_file_path(), &parse_func/1)

      expected_result = [%{first_name: "Nhu", last_name: "Nguyen", gitusername: "nhu313"},
                         %{first_name: "Kristofer", last_name: "Younger", gitusername: "kristofer"}]
      assert results == expected_result
    end

    defp parse_func({:ok, ["" | _]}) do
      nil
    end

    defp parse_func({:ok, [first_name, last_name, gitusername | _]}) do
      %{first_name: first_name,
        last_name: last_name,
        gitusername: String.downcase(gitusername)}
    end

    defp get_file_path() do
      %{path: Path.expand("../..//data/student.csv", __DIR__)}
    end
  end
end
