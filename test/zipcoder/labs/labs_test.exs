defmodule Zipcoder.LabsTest do
  use Zipcoder.DataCase

  alias Zipcoder.Labs
  alias Zipcoder.Accounts
  alias Zipcoder.Students


  describe "labs" do
    alias Zipcoder.Labs.Lab

    @valid_attrs %{name: "some name", repo_name: "some repo_name"}
    @update_attrs %{name: "some updated name", repo_name: "some updated repo_name"}
    @invalid_attrs %{name: nil, repo_name: nil}

    def lab_fixture(attrs \\ %{}) do
      {:ok, lab} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Labs.create_lab()

      lab
    end

    test "list_labs/0 returns all labs" do
      lab = lab_fixture()
      assert Labs.list_labs() == [lab]
    end

    test "get_lab!/1 returns the lab with given id" do
      lab = lab_fixture()
      assert Labs.get_lab!(lab.id) == lab
    end

    test "create_lab/1 with valid data creates a lab" do
      assert {:ok, %Lab{} = lab} = Labs.create_lab(@valid_attrs)
      assert lab.name == "some name"
      assert lab.repo_name == "some repo_name"
    end

    test "create_lab/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Labs.create_lab(@invalid_attrs)
    end

    test "update_lab/2 with valid data updates the lab" do
      lab = lab_fixture()
      assert {:ok, lab} = Labs.update_lab(lab, @update_attrs)
      assert %Lab{} = lab
      assert lab.name == "some updated name"
      assert lab.repo_name == "some updated repo_name"
    end

    test "update_lab/2 with invalid data returns error changeset" do
      lab = lab_fixture()
      assert {:error, %Ecto.Changeset{}} = Labs.update_lab(lab, @invalid_attrs)
      assert lab == Labs.get_lab!(lab.id)
    end

    test "delete_lab/1 deletes the lab" do
      lab = lab_fixture()
      assert {:ok, %Lab{}} = Labs.delete_lab(lab)
      assert_raise Ecto.NoResultsError, fn -> Labs.get_lab!(lab.id) end
    end

    test "change_lab/1 returns a lab changeset" do
      lab = lab_fixture()
      assert %Ecto.Changeset{} = Labs.change_lab(lab)
    end

    test "labs_without_pr/1 does not returns the lab with PR" do
      lab = lab_fixture()
      {:ok, student} = Accounts.create_student(%{first_name: "nhu", last_name: "NN", gitusername: "nhu313"})
      Students.create_lab_status(%{lab_id: lab.id, student_id: student.id})

      assert Labs.labs_without_pr(student) == []
    end

    test "labs_without_pr/1 returns labs without PR" do
      lab = lab_fixture()
      {:ok, watever_student} = Accounts.create_student(%{first_name: "wat", last_name: "ever", gitusername: "watever"})
      Students.create_lab_status(%{lab_id: lab.id, student_id: watever_student.id})

      {:ok, student} = Accounts.create_student(%{first_name: "nhu", last_name: "NN", gitusername: "nhu313"})

      [fetched_lab] = Labs.labs_without_pr(student)
      assert fetched_lab.id == lab.id
    end

    test "students_without_pr_for_lab/1 does not returns student with PR" do
      lab = lab_fixture()
      {:ok, student} = Accounts.create_student(%{first_name: "nhu", last_name: "NN", gitusername: "nhu313"})
      Students.create_lab_status(%{lab_id: lab.id, student_id: student.id})

      assert Labs.students_without_pr_for_lab(lab) == []
    end

    test "students_without_pr_for_lab/1 returns students without PR" do
      lab = lab_fixture()
      lab2 = lab_fixture()

      {:ok, student} = Accounts.create_student(%{first_name: "nhu", last_name: "NN", gitusername: "nhu313"})
      Students.create_lab_status(%{lab_id: lab2.id, student_id: student.id})

      [student] = Labs.students_without_pr_for_lab(lab)
      assert student.id == student.id
    end
  end

  describe "lab_statuses" do
    alias Zipcoder.Labs.Status

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def status_fixture(attrs \\ %{}) do
      {:ok, status} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Labs.create_status()

      status
    end

    test "list_lab_statuses/0 returns all lab_statuses" do
      status = status_fixture()
      assert Labs.list_lab_statuses() == [status]
    end

    test "get_status!/1 returns the status with given id" do
      status = status_fixture()
      assert Labs.get_status!(status.id) == status
    end

    test "create_status/1 with valid data creates a status" do
      assert {:ok, %Status{} = status} = Labs.create_status(@valid_attrs)
      assert status.name == "some name"
    end

    test "create_status/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Labs.create_status(@invalid_attrs)
    end

    test "update_status/2 with valid data updates the status" do
      status = status_fixture()
      assert {:ok, status} = Labs.update_status(status, @update_attrs)
      assert %Status{} = status
      assert status.name == "some updated name"
    end

    test "update_status/2 with invalid data returns error changeset" do
      status = status_fixture()
      assert {:error, %Ecto.Changeset{}} = Labs.update_status(status, @invalid_attrs)
      assert status == Labs.get_status!(status.id)
    end

    test "delete_status/1 deletes the status" do
      status = status_fixture()
      assert {:ok, %Status{}} = Labs.delete_status(status)
      assert_raise Ecto.NoResultsError, fn -> Labs.get_status!(status.id) end
    end

    test "change_status/1 returns a status changeset" do
      status = status_fixture()
      assert %Ecto.Changeset{} = Labs.change_status(status)
    end
  end

  describe "status_logs" do
    alias Zipcoder.Labs.StatusLogs

    @valid_attrs %{message: "some message"}
    @update_attrs %{message: "some updated message"}
    @invalid_attrs %{message: nil}

    def status_logs_fixture(attrs \\ %{}) do
      {:ok, status_logs} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Labs.create_status_logs()

      status_logs
    end

    test "list_status_logs/0 returns all status_logs" do
      status_logs = status_logs_fixture()
      assert Labs.list_status_logs() == [status_logs]
    end

    test "get_status_logs!/1 returns the status_logs with given id" do
      status_logs = status_logs_fixture()
      assert Labs.get_status_logs!(status_logs.id) == status_logs
    end

    test "create_status_logs/1 with valid data creates a status_logs" do
      assert {:ok, %StatusLogs{} = status_logs} = Labs.create_status_logs(@valid_attrs)
      assert status_logs.message == "some message"
    end

    test "create_status_logs/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Labs.create_status_logs(@invalid_attrs)
    end

    test "update_status_logs/2 with valid data updates the status_logs" do
      status_logs = status_logs_fixture()
      assert {:ok, status_logs} = Labs.update_status_logs(status_logs, @update_attrs)
      assert %StatusLogs{} = status_logs
      assert status_logs.message == "some updated message"
    end

    test "update_status_logs/2 with invalid data returns error changeset" do
      status_logs = status_logs_fixture()
      assert {:error, %Ecto.Changeset{}} = Labs.update_status_logs(status_logs, @invalid_attrs)
      assert status_logs == Labs.get_status_logs!(status_logs.id)
    end

    test "delete_status_logs/1 deletes the status_logs" do
      status_logs = status_logs_fixture()
      assert {:ok, %StatusLogs{}} = Labs.delete_status_logs(status_logs)
      assert_raise Ecto.NoResultsError, fn -> Labs.get_status_logs!(status_logs.id) end
    end

    test "change_status_logs/1 returns a status_logs changeset" do
      status_logs = status_logs_fixture()
      assert %Ecto.Changeset{} = Labs.change_status_logs(status_logs)
    end
  end
end
