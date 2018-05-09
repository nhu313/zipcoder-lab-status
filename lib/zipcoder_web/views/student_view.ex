defmodule ZipcoderWeb.StudentView do
  use ZipcoderWeb, :view

  def format_name(student) do
    Zipcoder.Formatter.student_name(student)
  end
end
