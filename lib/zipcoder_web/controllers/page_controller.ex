defmodule ZipcoderWeb.PageController do
  use ZipcoderWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
