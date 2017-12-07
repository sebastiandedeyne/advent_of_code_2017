defmodule AdventOfCode2017.Day1 do
  @doc """
      iex> AdventOfCode2017.Day1.inverse_captcha("1122")
      3
      iex> AdventOfCode2017.Day1.inverse_captcha("1111")
      4
      iex> AdventOfCode2017.Day1.inverse_captcha("1234")
      0
      iex> File.read!("priv/input/day1")
      ...> |> String.trim()
      ...> |> AdventOfCode2017.Day1.inverse_captcha()
      1216
  """
  def inverse_captcha(numbers) do
    numbers
    |> string_to_numbers()
    |> pair_with_next()
    |> get_duplicates()
    |> sum()
  end

  @doc """
      iex> AdventOfCode2017.Day1.inverse_captcha_circular("1212")
      6
      iex> AdventOfCode2017.Day1.inverse_captcha_circular("1221")
      0
      iex> AdventOfCode2017.Day1.inverse_captcha_circular("123425")
      4
      iex> AdventOfCode2017.Day1.inverse_captcha_circular("123123")
      12
      iex> AdventOfCode2017.Day1.inverse_captcha_circular("12131415")
      4
      iex> File.read!("priv/input/day1")
      ...> |> String.trim()
      ...> |> AdventOfCode2017.Day1.inverse_captcha_circular()
      1072
  """
  def inverse_captcha_circular(numbers) do
    numbers
    |> string_to_numbers()
    |> pair_with_circular_opposite()
    |> get_duplicates()
    |> sum()
  end

  defp string_to_numbers(string) do
    string
    |> String.codepoints()
    |> Enum.map(fn s -> String.to_integer(s) end)
  end

  defp pair_with_next(numbers) do
    numbers
    |> Enum.with_index()
    |> Enum.map(fn {number, index} ->
      {number, Enum.at(numbers, index + 1, Enum.at(numbers, 0))}
    end)
  end

  defp pair_with_circular_opposite(numbers) do
    halfway = round(length(numbers) / 2)

    numbers
    |> Enum.with_index()
    |> Enum.map(fn {number, index} ->
      cond do
        index >= halfway -> {number, Enum.at(numbers, index - halfway)}
        true -> {number, Enum.at(numbers, index + halfway)}
      end
    end)
  end

  defp get_duplicates(numbers) do
    numbers
    |> Enum.filter(fn {n, m} -> n == m end)
    |> Enum.map(fn {n, _} -> n end)
  end

  defp sum(list), do: sum(list, 0)
  defp sum([], acc), do: acc
  defp sum([h | t], acc), do: sum(t, acc + h)
end
