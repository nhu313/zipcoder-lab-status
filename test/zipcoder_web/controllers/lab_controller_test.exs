defmodule ZipcoderWeb.LabControllerTest do
  use ZipcoderWeb.ConnCase

  alias Zipcoder.Labs

  @create_attrs %{name: "some name", repo_name: "some repo_name"}
  @update_attrs %{name: "some updated name", repo_name: "some updated repo_name"}
  @invalid_attrs %{name: nil, repo_name: nil}

  def fixture(:lab) do
    {:ok, lab} = Labs.create_lab(@create_attrs)
    lab
  end

  describe "index" do
    test "lists all labs", %{conn: conn} do
      conn = get conn, lab_path(conn, :index)
      assert html_response(conn, 200) =~ "Labs"
    end
  end

  describe "new lab" do
    test "renders form", %{conn: conn} do
      conn = get conn, lab_path(conn, :new)
      assert html_response(conn, 200) =~ "New Lab"
    end
  end

  describe "create lab" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, lab_path(conn, :create), lab: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == lab_path(conn, :show, id)

      conn = get conn, lab_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Completed"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, lab_path(conn, :create), lab: @invalid_attrs
      assert html_response(conn, 200) =~ "New Lab"
    end
  end

  describe "edit lab" do
    setup [:create_lab]

    test "renders form for editing chosen lab", %{conn: conn, lab: lab} do
      conn = get conn, lab_path(conn, :edit, lab)
      assert html_response(conn, 200) =~ "Edit Lab"
    end
  end

  describe "update lab" do
    setup [:create_lab]

    test "redirects when data is valid", %{conn: conn, lab: lab} do
      conn = put conn, lab_path(conn, :update, lab), lab: @update_attrs
      assert redirected_to(conn) == lab_path(conn, :show, lab)

      conn = get conn, lab_path(conn, :show, lab)
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, lab: lab} do
      conn = put conn, lab_path(conn, :update, lab), lab: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Lab"
    end
  end


  defp create_lab(_) do
    lab = fixture(:lab)
    {:ok, lab: lab}
  end
end
