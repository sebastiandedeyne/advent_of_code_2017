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
  def inverse_captcha(input) do
    input
    |> to_numbers()
    |> pair_with_next()
    |> summate_duplicates()
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
  def inverse_captcha_circular(input) do
    input
    |> to_numbers()
    |> pair_with_circular_opposites()
    |> summate_duplicates()
  end

  defp to_numbers(string) do
    string
    |> String.codepoints()
    |> Enum.map(&String.to_integer/1)
  end

  defp pair_with_next(numbers) do
    Enum.zip(numbers, Enum.take(numbers, -1) ++ numbers)
  end

  defp pair_with_circular_opposites(numbers) do
    numbers
    |> Enum.chunk_every(round(length(numbers) / 2))
    |> Enum.reverse()
    |> Enum.concat()
    |> (&Enum.zip(numbers, &1)).()
  end

  defp summate_duplicates(numbers) do
    numbers
    |> Enum.filter(fn {n, m} -> n == m end)
    |> Enum.map(fn {n, _} -> n end)
    |> Enum.sum()
  end
end
