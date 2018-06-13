defmodule Zipcoder.Formatter do

  def percent(fraction) do
    Integer.to_string(round(fraction * 100)) <> "%"
  end

  def inverse_percent(fraction) do
    percent(1 - fraction)
  end

  def student_name(%{first_name: first_name, last_name: last_name}) do
    first_name <> " " <> last_name
  end

  def student_name(_), do: ""

  def repo_link("http" <> _ = link) do
    link
  end

  def repo_link(lab_name) do
    "https://git.zipcode.rocks/ZipCodeWilmington/" <> lab_name
  end
end
