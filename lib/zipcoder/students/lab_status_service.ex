defmodule Zipcoder.Students.LabStatusService do
  alias Zipcoder.Labs
  alias Zipcoder.Accounts
  alias Zipcoder.Students
  alias Zipcoder.Accounts.Student

  def create(json) do
    parsed_json = parse_json(json)
    result = with %{id: student_id} <- Accounts.get_student_by_gitusername(parsed_json.username),
                  %{id: lab_id} <- Labs.get_lab_by_repo_name(parsed_json.repo_name),
                  %{id: status_id} <- Labs.get_status_by_name(parsed_json.action),
                   do: Students.create_lab_status(%{
                                                    lab_id: lab_id,
                                                    student_id: student_id,
                                                    status_id: status_id,
                                                    url: parsed_json.url
                                                  })

    log(Poison.encode(json), parsed_json.url, result)

    result
  end

  defp log({:ok, message}, url, {:ok, %Student{id: lab_status_id}}) do
    Labs.create_status_logs(%{message: message, lab_status_id: lab_status_id, url: url})
  end

  defp log({:ok, message}, url, _) do
    Labs.create_status_logs(%{message: message, url: url})
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
