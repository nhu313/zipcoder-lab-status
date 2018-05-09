defmodule Zipcoder.Formatter do

  def student_name(%{first_name: first_name, last_name: last_name}) do
    first_name <> " " <> last_name
  end

  def student_name(_), do: ""
end
