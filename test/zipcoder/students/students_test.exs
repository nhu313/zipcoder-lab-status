defmodule Zipcoder.StudentsTest do
  use Zipcoder.DataCase

  alias Zipcoder.Students

  describe "student_lab_statuses" do
    alias Zipcoder.Students.LabStatus

    @valid_attrs %{lab_id: 42, status_id: 42, student_id: 42, url: "some url"}
    @update_attrs %{lab_id: 43, status_id: 43, student_id: 43, url: "some updated url"}
    @invalid_attrs %{lab_id: nil, status_id: nil, student_id: nil, url: nil}

    def lab_status_fixture(attrs \\ %{}) do
      {:ok, lab_status} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Students.create_lab_status()

      lab_status
    end

    test "list_student_lab_statuses/0 returns all student_lab_statuses" do
      lab_status = lab_status_fixture()
      assert Students.list_student_lab_statuses() == [lab_status]
    end

    test "get_lab_status!/1 returns the lab_status with given id" do
      lab_status = lab_status_fixture()
      assert Students.get_lab_status!(lab_status.id) == lab_status
    end

    test "create_lab_status/1 with valid data creates a lab_status" do
      assert {:ok, %LabStatus{} = lab_status} = Students.create_lab_status(@valid_attrs)
      assert lab_status.lab_id == 42
      assert lab_status.status_id == 42
      assert lab_status.student_id == 42
      assert lab_status.url == "some url"
    end

    test "create_lab_status/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Students.create_lab_status(@invalid_attrs)
    end

    test "update_lab_status/2 with valid data updates the lab_status" do
      lab_status = lab_status_fixture()
      assert {:ok, lab_status} = Students.update_lab_status(lab_status, @update_attrs)
      assert %LabStatus{} = lab_status
      assert lab_status.lab_id == 43
      assert lab_status.status_id == 43
      assert lab_status.student_id == 43
      assert lab_status.url == "some updated url"
    end

    test "update_lab_status/2 with invalid data returns error changeset" do
      lab_status = lab_status_fixture()
      assert {:error, %Ecto.Changeset{}} = Students.update_lab_status(lab_status, @invalid_attrs)
      assert lab_status == Students.get_lab_status!(lab_status.id)
    end

    test "delete_lab_status/1 deletes the lab_status" do
      lab_status = lab_status_fixture()
      assert {:ok, %LabStatus{}} = Students.delete_lab_status(lab_status)
      assert_raise Ecto.NoResultsError, fn -> Students.get_lab_status!(lab_status.id) end
    end

    test "change_lab_status/1 returns a lab_status changeset" do
      lab_status = lab_status_fixture()
      assert %Ecto.Changeset{} = Students.change_lab_status(lab_status)
    end
  end
end
