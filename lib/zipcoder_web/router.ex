defmodule ZipcoderWeb.Router do
  use ZipcoderWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ZipcoderWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    post "/students/create_all", StudentController, :create_all
    resources "/students", StudentController

    resources "/labs/status_logs", StatusLogsController
    resources "/labs", LabController
    resources "/lab_statuses", StatusController
    resources "/student_lab_statuses", LabStatusController
  end

  # Other scopes may use custom stacks.
  scope "/api", ZipcoderWeb do
    pipe_through :api

    post "/labs/statuses", ZipcoderWeb.StatusController, :create_hook
  end
end
