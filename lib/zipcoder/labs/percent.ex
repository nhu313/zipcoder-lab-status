defmodule Zipcoder.Labs.Percent do
  defstruct value: 0, total: 0, percent: 0

  def create(value, 0) do
    %__MODULE__{value: value}
  end

  def create(value, total) do
    %__MODULE__{total: total, value: value, percent: ((value/total) * 100)}
  end
end
