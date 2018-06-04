defmodule ZipcoderWeb.AssessmentControllerTest do
  use ZipcoderWeb.ConnCase

  alias Zipcoder.Assessments

  @create_attrs %{max_score: 42, name: "some name", passing_score: 42, type: "some type"}
  @update_attrs %{max_score: 43, name: "some updated name", passing_score: 43, type: "some updated type"}
  @invalid_attrs %{max_score: nil, name: nil, passing_score: nil, type: nil}

  def fixture(:assessment) do
    {:ok, assessment} = Assessments.create_assessment(@create_attrs)
    assessment
  end

  describe "index" do
    test "lists all assessments", %{conn: conn} do
      conn = get conn, assessment_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Assessments"
    end
  end

  describe "new assessment" do
    test "renders form", %{conn: conn} do
      conn = get conn, assessment_path(conn, :new)
      assert html_response(conn, 200) =~ "New Assessment"
    end
  end

  describe "create assessment" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, assessment_path(conn, :create), assessment: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == assessment_path(conn, :show, id)

      conn = get conn, assessment_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Assessment"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, assessment_path(conn, :create), assessment: @invalid_attrs
      assert html_response(conn, 200) =~ "New Assessment"
    end
  end

  describe "edit assessment" do
    setup [:create_assessment]

    test "renders form for editing chosen assessment", %{conn: conn, assessment: assessment} do
      conn = get conn, assessment_path(conn, :edit, assessment)
      assert html_response(conn, 200) =~ "Edit Assessment"
    end
  end

  describe "update assessment" do
    setup [:create_assessment]

    test "redirects when data is valid", %{conn: conn, assessment: assessment} do
      conn = put conn, assessment_path(conn, :update, assessment), assessment: @update_attrs
      assert redirected_to(conn) == assessment_path(conn, :show, assessment)

      conn = get conn, assessment_path(conn, :show, assessment)
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, assessment: assessment} do
      conn = put conn, assessment_path(conn, :update, assessment), assessment: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Assessment"
    end
  end

  describe "delete assessment" do
    setup [:create_assessment]

    test "deletes chosen assessment", %{conn: conn, assessment: assessment} do
      conn = delete conn, assessment_path(conn, :delete, assessment)
      assert redirected_to(conn) == assessment_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, assessment_path(conn, :show, assessment)
      end
    end
  end

  defp create_assessment(_) do
    assessment = fixture(:assessment)
    {:ok, assessment: assessment}
  end
end
