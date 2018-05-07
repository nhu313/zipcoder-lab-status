defmodule ZipcoderWeb.LabStatusControllerTest do
  use ZipcoderWeb.ConnCase

  alias Zipcoder.Students

  @create_attrs %{lab_id: 42, status_id: 42, student_id: 42, url: "some url"}
  @update_attrs %{lab_id: 43, status_id: 43, student_id: 43, url: "some updated url"}
  @invalid_attrs %{lab_id: nil, status_id: nil, student_id: nil, url: nil}

  def fixture(:lab_status) do
    {:ok, lab_status} = Students.create_lab_status(@create_attrs)
    lab_status
  end

  describe "index" do
    test "lists all student_lab_statuses", %{conn: conn} do
      conn = get conn, lab_status_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Student lab statuses"
    end
  end

  describe "new lab_status" do
    test "renders form", %{conn: conn} do
      conn = get conn, lab_status_path(conn, :new)
      assert html_response(conn, 200) =~ "New Lab status"
    end
  end

  describe "create lab_status" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, lab_status_path(conn, :create), lab_status: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == lab_status_path(conn, :show, id)

      conn = get conn, lab_status_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Lab status"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, lab_status_path(conn, :create), lab_status: @invalid_attrs
      assert html_response(conn, 200) =~ "New Lab status"
    end
  end

  describe "edit lab_status" do
    setup [:create_lab_status]

    test "renders form for editing chosen lab_status", %{conn: conn, lab_status: lab_status} do
      conn = get conn, lab_status_path(conn, :edit, lab_status)
      assert html_response(conn, 200) =~ "Edit Lab status"
    end
  end

  describe "update lab_status" do
    setup [:create_lab_status]

    test "redirects when data is valid", %{conn: conn, lab_status: lab_status} do
      conn = put conn, lab_status_path(conn, :update, lab_status), lab_status: @update_attrs
      assert redirected_to(conn) == lab_status_path(conn, :show, lab_status)

      conn = get conn, lab_status_path(conn, :show, lab_status)
      assert html_response(conn, 200) =~ "some updated"
    end

    test "renders errors when data is invalid", %{conn: conn, lab_status: lab_status} do
      conn = put conn, lab_status_path(conn, :update, lab_status), lab_status: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Lab status"
    end
  end

  describe "delete lab_status" do
    setup [:create_lab_status]

    test "deletes chosen lab_status", %{conn: conn, lab_status: lab_status} do
      conn = delete conn, lab_status_path(conn, :delete, lab_status)
      assert redirected_to(conn) == lab_status_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, lab_status_path(conn, :show, lab_status)
      end
    end
  end

  defp create_lab_status(_) do
    lab_status = fixture(:lab_status)
    {:ok, lab_status: lab_status}
  end
end
