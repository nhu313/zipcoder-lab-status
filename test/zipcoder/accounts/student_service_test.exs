defmodule Zipcoder.Accounts.StudentServiceTest do
  use Zipcoder.DataCase
  alias Zipcoder.Repo

  describe "create_all" do
    alias Zipcoder.Accounts.Student
    alias Zipcoder.Accounts.StudentService

    test "create_students" do
      file = %{path: Path.expand("../..//data/student.csv", __DIR__)}
      results = StudentService.create_all(file)

      assert length(Repo.all(Student)) == 2
    end

    test "parse file" do
      file = %{path: Path.expand("../..//data/student.csv", __DIR__)}
      results = StudentService.parse_file(file)

      expected_result = [%{first_name: "Nhu", last_name: "Nguyen", gitusername: "nhu313"},
                         %{first_name: "Kristofer", last_name: "Younger", gitusername: "kristofer"}]
      assert results == expected_result
    end

  end
end
