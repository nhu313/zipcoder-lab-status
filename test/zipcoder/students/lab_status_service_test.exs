defmodule Zipcoder.Students.LabStatusServiceTest do
  use Zipcoder.DataCase
  alias Zipcoder.Labs
  alias Zipcoder.Students
  alias Zipcoder.Accounts
  use ExUnit.Case, async: true

  describe "create" do
    alias Zipcoder.Students.LabStatusService

    test "create lab status" do
      {:ok, student} = Accounts.create_student(%{first_name: "nhu", last_name: "NN", gitusername: "nhu313"})
      {:ok, status} = Labs.create_status(%{name: "opened"})
      {:ok, lab} = Labs.create_lab(%{name: "hash", repo_name: "Lab-ZipcoderStore-HashMap"})

      file = read_file()

      LabStatusService.create(file)

      [lab_status] = Students.list_student_lab_statuses()

      assert lab_status.lab_id == lab.id
      assert lab_status.status_id == status.id
      assert lab_status.student_id == student.id
    end

    test "create log without status" do
      file = read_file()
      LabStatusService.create(file)

      [log] = Labs.list_status_logs
      assert log.message =~ "Lab-ZipcoderStore-HashMap"
    end

    test "parse file" do
      status = read_file() |> LabStatusService.parse_json()

      assert status.url == "https://git.zipcode.rocks/nhu313/Lab-ZipcoderStore-HashMap/pulls/3"
      assert status.username == "nhu313"
      assert status.repo_name == "Lab-ZipcoderStore-HashMap"
    end

    def read_file() do
      file = File.read!(Path.expand("../../data/gitea_pr_open.json", __DIR__))
      Poison.decode!(file)
    end
  end
end
