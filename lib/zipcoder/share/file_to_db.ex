defmodule Zipcoder.FileToDb do

  def create_from_file(file, parsc_func, create_func) do
    file
    |> parse_file(parsc_func)
    |> Enum.map(create_func)
  end

  def parse_file(file, parsc_func) do
    file.path
    |> File.stream!
    |> CSV.decode
    |> Stream.drop(1)
    |> Stream.map(parsc_func)
    |> Stream.reject(&(&1 == nil))
    |> Enum.to_list()
  end
end
