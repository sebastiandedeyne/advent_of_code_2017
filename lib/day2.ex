defmodule AdventOfCode2017.Day2 do
  @doc """
    iex> AdventOfCode2017.Day2.range_checksum([[5, 1, 9, 5], [7, 5, 3], [2, 4, 6, 8]])
    18

    iex> AdventOfCode2017.Day2.range_checksum("priv/input/day2")
    48357
  """
  def range_checksum(input) when is_list(input) do
    input
    |> Enum.map(&range/1)
    |> Enum.sum()
  end
  def range_checksum(path) when is_binary(path) do
    load_spreadsheet(path)
    |> range_checksum()
  end

  @doc """
    iex> AdventOfCode2017.Day2.division_checksum([[5, 9, 2, 8], [9, 4, 7, 3], [3, 8, 6, 5]])
    9

    iex> AdventOfCode2017.Day2.division_checksum("priv/input/day2")
    351
  """
  def division_checksum(input) when is_list(input) do
    input
    |> Enum.map(&evenly_divisible_numbers/1)
    |> Enum.map(&quotient/1)
    |> Enum.sum()
  end
  def division_checksum(path) when is_binary(path) do
    load_spreadsheet(path)
    |> division_checksum()
  end

  defp range(row) do
    Enum.max(row) - Enum.min(row)
  end

  defp evenly_divisible_numbers(row) do
    cartesian_product(row, row)
    |> Enum.find(fn {a, b} -> a != b && rem(a, b) == 0 end)
  end

  defp cartesian_product(a, b) do
    for i <- a, j <- b, do: {i, j}
  end

  defp quotient({a, b}), do: round(a / b)

  defp load_spreadsheet(path) do
    File.read!(path)
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(fn row -> String.split(row, " ") |> Enum.map(&String.to_integer/1) end)
  end
end
