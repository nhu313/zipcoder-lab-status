defmodule Zipcoder.AssessmentsTest do
  use Zipcoder.DataCase

  alias Zipcoder.Assessments

  describe "assessments" do
    alias Zipcoder.Assessments.Assessment

    @valid_attrs %{max_score: 42, name: "some name", passing_score: 42, type: "some type"}
    @update_attrs %{max_score: 43, name: "some updated name", passing_score: 43, type: "some updated type"}
    @invalid_attrs %{max_score: nil, name: nil, passing_score: nil, type: nil}

    def assessment_fixture(attrs \\ %{}) do
      {:ok, assessment} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Assessments.create_assessment()

      assessment
    end

    test "list_assessments/0 returns all assessments" do
      assessment = assessment_fixture()
      assert Assessments.list_assessments() == [assessment]
    end

    test "get_assessment!/1 returns the assessment with given id" do
      assessment = assessment_fixture()
      assert Assessments.get_assessment!(assessment.id) == assessment
    end

    test "create_assessment/1 with valid data creates a assessment" do
      assert {:ok, %Assessment{} = assessment} = Assessments.create_assessment(@valid_attrs)
      assert assessment.max_score == 42
      assert assessment.name == "some name"
      assert assessment.passing_score == 42
      assert assessment.type == "some type"
    end

    test "create_assessment/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Assessments.create_assessment(@invalid_attrs)
    end

    test "update_assessment/2 with valid data updates the assessment" do
      assessment = assessment_fixture()
      assert {:ok, assessment} = Assessments.update_assessment(assessment, @update_attrs)
      assert %Assessment{} = assessment
      assert assessment.max_score == 43
      assert assessment.name == "some updated name"
      assert assessment.passing_score == 43
      assert assessment.type == "some updated type"
    end

    test "update_assessment/2 with invalid data returns error changeset" do
      assessment = assessment_fixture()
      assert {:error, %Ecto.Changeset{}} = Assessments.update_assessment(assessment, @invalid_attrs)
      assert assessment == Assessments.get_assessment!(assessment.id)
    end

    test "delete_assessment/1 deletes the assessment" do
      assessment = assessment_fixture()
      assert {:ok, %Assessment{}} = Assessments.delete_assessment(assessment)
      assert_raise Ecto.NoResultsError, fn -> Assessments.get_assessment!(assessment.id) end
    end

    test "change_assessment/1 returns a assessment changeset" do
      assessment = assessment_fixture()
      assert %Ecto.Changeset{} = Assessments.change_assessment(assessment)
    end
  end

  describe "assessment_results" do
    alias Zipcoder.Assessments.Result

    @valid_attrs %{assessment_id: 42, score: 42, student_id: 42}
    @update_attrs %{assessment_id: 43, score: 43, student_id: 43}
    @invalid_attrs %{assessment_id: nil, score: nil, student_id: nil}

    def result_fixture(attrs \\ %{}) do
      {:ok, result} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Assessments.create_result()

      result
    end

    test "list_assessment_results/0 returns all assessment_results" do
      result = result_fixture()
      assert Assessments.list_assessment_results() == [result]
    end

    test "get_result!/1 returns the result with given id" do
      result = result_fixture()
      assert Assessments.get_result!(result.id) == result
    end

    test "create_result/1 with valid data creates a result" do
      assert {:ok, %Result{} = result} = Assessments.create_result(@valid_attrs)
      assert result.assessment_id == 42
      assert result.score == 42
      assert result.student_id == 42
    end

    test "create_result/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Assessments.create_result(@invalid_attrs)
    end

    test "update_result/2 with valid data updates the result" do
      result = result_fixture()
      assert {:ok, result} = Assessments.update_result(result, @update_attrs)
      assert %Result{} = result
      assert result.assessment_id == 43
      assert result.score == 43
      assert result.student_id == 43
    end

    test "update_result/2 with invalid data returns error changeset" do
      result = result_fixture()
      assert {:error, %Ecto.Changeset{}} = Assessments.update_result(result, @invalid_attrs)
      assert result == Assessments.get_result!(result.id)
    end

    test "delete_result/1 deletes the result" do
      result = result_fixture()
      assert {:ok, %Result{}} = Assessments.delete_result(result)
      assert_raise Ecto.NoResultsError, fn -> Assessments.get_result!(result.id) end
    end

    test "change_result/1 returns a result changeset" do
      result = result_fixture()
      assert %Ecto.Changeset{} = Assessments.change_result(result)
    end
  end
end
