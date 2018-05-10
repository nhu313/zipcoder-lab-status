defmodule Zipcoder.Accounts.StudentServiceTest do
  use Zipcoder.DataCase
  alias Zipcoder.Repo

  describe "create_all" do
    alias Zipcoder.Accounts.Student
    alias Zipcoder.Accounts.StudentService

    test "create_students" do
      file = %{path: Path.expand("../..//data/student.csv", __DIR__)}
      StudentService.create_from_file(file)

      assert length(Repo.all(Student)) == 2
    end
  end
end
