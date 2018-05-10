defmodule Zipcoder.Accounts.LabServiceTest do
  use Zipcoder.DataCase

  describe "create_all" do
    alias Zipcoder.Labs
    alias Zipcoder.Labs.LabService

    test "create_from_file" do
      file = %{path: Path.expand("../..//data/labs.csv", __DIR__)}
      LabService.create_from_file(file)

      assert Labs.count_labs() == 2
    end
  end
end
