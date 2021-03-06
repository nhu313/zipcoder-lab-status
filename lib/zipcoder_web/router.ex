defmodule ZipcoderWeb.Router do
  use ZipcoderWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug BasicAuth, username: System.get_env("ZIPCODER_USER"), password: System.get_env("ZIPCODER_PW")
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ZipcoderWeb do
    pipe_through :browser # Use the default browser stack

    get "/", StudentController, :index
    resources "/students/lab_statuses", LabStatusController
    post "/labs/statuses/create_all", LabStatusController, :create_all
    post "/students/create_all", StudentController, :create_all
    resources "/students", StudentController

    post "/labs/create_all", LabController, :create_all
    post "/labs/status_logs/process/:id", StatusLogsController, :process
    resources "/labs/status_logs", StatusLogsController
    resources "/labs", LabController

    resources "/lab_statuses", StatusController

    resources "/assessments", AssessmentController
    resources "/assessment_results", ResultController
  end

  # Other scopes may use custom stacks.
  scope "/api", ZipcoderWeb do
    pipe_through :api

    post "/labs/statuses", LabStatusController, :create_hook
  end
end
