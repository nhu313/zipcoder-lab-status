defmodule ZipcoderWeb.StatusLogsControllerTest do
  use ZipcoderWeb.ConnCase

  alias Zipcoder.Labs

  @create_attrs %{message: "some message"}
  @update_attrs %{message: "some updated message"}
  @invalid_attrs %{message: nil}

  def fixture(:status_logs) do
    {:ok, status_logs} = Labs.create_status_logs(@create_attrs)
    status_logs
  end

  describe "index" do
    test "lists all status_logs", %{conn: conn} do
      conn = get conn, status_logs_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Status logs"
    end
  end

  describe "new status_logs" do
    test "renders form", %{conn: conn} do
      conn = get conn, status_logs_path(conn, :new)
      assert html_response(conn, 200) =~ "New Status logs"
    end
  end

  describe "create status_logs" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, status_logs_path(conn, :create), status_logs: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == status_logs_path(conn, :show, id)

      conn = get conn, status_logs_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Status logs"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, status_logs_path(conn, :create), status_logs: @invalid_attrs
      assert html_response(conn, 200) =~ "New Status logs"
    end
  end

  describe "edit status_logs" do
    setup [:create_status_logs]

    test "renders form for editing chosen status_logs", %{conn: conn, status_logs: status_logs} do
      conn = get conn, status_logs_path(conn, :edit, status_logs)
      assert html_response(conn, 200) =~ "Edit Status logs"
    end
  end

  describe "update status_logs" do
    setup [:create_status_logs]

    test "redirects when data is valid", %{conn: conn, status_logs: status_logs} do
      conn = put conn, status_logs_path(conn, :update, status_logs), status_logs: @update_attrs
      assert redirected_to(conn) == status_logs_path(conn, :show, status_logs)

      conn = get conn, status_logs_path(conn, :show, status_logs)
      assert html_response(conn, 200) =~ "some updated message"
    end

    test "renders errors when data is invalid", %{conn: conn, status_logs: status_logs} do
      conn = put conn, status_logs_path(conn, :update, status_logs), status_logs: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Status logs"
    end
  end

  describe "delete status_logs" do
    setup [:create_status_logs]

    test "deletes chosen status_logs", %{conn: conn, status_logs: status_logs} do
      conn = delete conn, status_logs_path(conn, :delete, status_logs)
      assert redirected_to(conn) == status_logs_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, status_logs_path(conn, :show, status_logs)
      end
    end
  end

  defp create_status_logs(_) do
    status_logs = fixture(:status_logs)
    {:ok, status_logs: status_logs}
  end
end
