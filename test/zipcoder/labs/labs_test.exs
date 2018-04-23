defmodule Zipcoder.LabsTest do
  use Zipcoder.DataCase

  alias Zipcoder.Labs

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
  end

  describe "lab_statuses" do
    alias Zipcoder.Labs.Status

    @valid_attrs %{status: "some status", student_id: 42}
    @update_attrs %{status: "some updated status", student_id: 43}
    @invalid_attrs %{status: nil, student_id: nil}

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
      assert status.status == "some status"
      assert status.student_id == 42
    end

    test "create_status/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Labs.create_status(@invalid_attrs)
    end

    test "update_status/2 with valid data updates the status" do
      status = status_fixture()
      assert {:ok, status} = Labs.update_status(status, @update_attrs)
      assert %Status{} = status
      assert status.status == "some updated status"
      assert status.student_id == 43
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
end
