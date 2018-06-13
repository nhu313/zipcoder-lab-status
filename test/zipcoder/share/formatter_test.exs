defmodule Zipcoder.FormatterTest do
  alias Zipcoder.Formatter
  use Zipcoder.DataCase


  test "repo link for full url" do
    assert Formatter.repo_link("http://google.com") == "http://google.com"
  end

  test "repo link" do
    assert Formatter.repo_link("lab2") == "https://git.zipcode.rocks/ZipCodeWilmington/lab2"
  end

end
