defmodule Day1 do
  @spec part1(binary()) :: integer()
  def part1(data) do
    to_integers(data)
    |> find_two_numbers_that_sum(2020)
    |> Enum.reduce(fn num, acc -> acc * num end)
  end

  @spec part2(binary()) :: integer()
  def part2(data) do
    to_integers(data)
    |> find_three_numbers_that_sum(2020)
    |> Enum.reduce(fn num, acc -> acc * num end)
  end

  defp to_integers(data) do
    data
    |> String.split("\n", trim: true)
    |> Enum.map(&String.to_integer/1)
  end

  defp find_three_numbers_that_sum(numbers, target_sum) do
    try do
      for num <- numbers,
          tuple = find_two_numbers_that_sum(numbers, target_sum - num),
          do: if(length(tuple) == 2, do: throw([num | tuple]))
    catch
      candidate -> candidate
    end
  end

  defp find_two_numbers_that_sum(numbers, target_sum) do
    candidates = for num <- numbers, into: %{}, do: {target_sum - num, num}
    Enum.filter(numbers, fn num -> Map.get(candidates, num) end)
  end
end
