defmodule ZipcoderWeb.StatusLogsView do
  use ZipcoderWeb, :view

  def message_str(%{message: message}) do
    {:ok, message_str} = Poison.encode(message)
    message_str
  end
end
