defmodule Zipcoder.Students.LabStatusService do
  alias Zipcoder.Labs
  alias Zipcoder.Accounts
  alias Zipcoder.Students
  alias Zipcoder.Accounts.Student

  def create_and_log(json) do
    result = create(json)
    log(json, result)

    result
  end

  def create(json) do
    parsed_json = parse_json(json)
    IO.inspect Accounts.get_student_by_gitusername(String.downcase(parsed_json.username))
    IO.inspect Labs.get_lab_by_repo_name(parsed_json.repo_name)
    IO.inspect Labs.get_status_by_name(parsed_json.action)
    result = with %{id: student_id} <- Accounts.get_student_by_gitusername(String.downcase(parsed_json.username)),
                  %{id: lab_id} <- Labs.get_lab_by_repo_name(parsed_json.repo_name),
                  %{id: status_id} <- Labs.get_status_by_name(parsed_json.action),
                   do: create_lab_status(student_id, lab_id, status_id, parsed_json.url)

    result
  end

  defp create_lab_status(student_id, lab_id, status_id, url) do
    status = Students.find_lab_status(student_id, lab_id, status_id)
    if status do
      status
    else
      Students.create_lab_status(%{
                                   lab_id: lab_id,
                                   student_id: student_id,
                                   status_id: status_id,
                                   url: url
                                 })
    end
  end

  defp log(message, {:ok, %Zipcoder.Students.LabStatus{id: lab_status_id, url: url}}) do
    Labs.create_status_logs(%{message: message, lab_status_id: lab_status_id, url: url})
  end

  defp log(message, status) do
    IO.puts "******* status is"
    IO.inspect status
    Labs.create_status_logs(%{message: message})
  end

  def parse_json(json) do
    %{
      url: json["pull_request"]["html_url"],
      username: json["pull_request"]["user"]["username"],
      repo_name: json["pull_request"]["base"]["repo"]["name"],
      action: json["action"]
    }
  end
end
