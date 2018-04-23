defmodule Zipcoder.AccountsTest do
  use Zipcoder.DataCase

  alias Zipcoder.Accounts

  describe "students" do
    alias Zipcoder.Accounts.Student

    @valid_attrs %{first_name: "some first_name", gitusername: "some gitusername", last_name: "some last_name"}
    @update_attrs %{first_name: "some updated first_name", gitusername: "some updated gitusername", last_name: "some updated last_name"}
    @invalid_attrs %{first_name: nil, gitusername: nil, last_name: nil}

    def student_fixture(attrs \\ %{}) do
      {:ok, student} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_student()

      student
    end

    test "list_students/0 returns all students" do
      student = student_fixture()
      assert Accounts.list_students() == [student]
    end

    test "get_student!/1 returns the student with given id" do
      student = student_fixture()
      assert Accounts.get_student!(student.id) == student
    end

    test "create_student/1 with valid data creates a student" do
      assert {:ok, %Student{} = student} = Accounts.create_student(@valid_attrs)
      assert student.first_name == "some first_name"
      assert student.gitusername == "some gitusername"
      assert student.last_name == "some last_name"
    end

    test "create_student/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_student(@invalid_attrs)
    end

    test "update_student/2 with valid data updates the student" do
      student = student_fixture()
      assert {:ok, student} = Accounts.update_student(student, @update_attrs)
      assert %Student{} = student
      assert student.first_name == "some updated first_name"
      assert student.gitusername == "some updated gitusername"
      assert student.last_name == "some updated last_name"
    end

    test "update_student/2 with invalid data returns error changeset" do
      student = student_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_student(student, @invalid_attrs)
      assert student == Accounts.get_student!(student.id)
    end

    test "delete_student/1 deletes the student" do
      student = student_fixture()
      assert {:ok, %Student{}} = Accounts.delete_student(student)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_student!(student.id) end
    end

    test "change_student/1 returns a student changeset" do
      student = student_fixture()
      assert %Ecto.Changeset{} = Accounts.change_student(student)
    end
  end
end
