defmodule Day2 do
  @spec part1(binary()) :: integer()
  def part1(data) do
    data
    |> String.split("\n", trim: true)
    |> Enum.map(&parse_policy/1)
    |> Enum.map(&valid_policy1?/1)
    |> Enum.count(& &1)
  end

  @spec part2(binary()) :: integer()
  def part2(data) do
    data
    |> String.split("\n", trim: true)
    |> Enum.map(&parse_policy/1)
    |> Enum.map(&valid_policy2?/1)
    |> Enum.count(& &1)
  end

  defp parse_policy(policy) do
    [_, min, max, char, password] = Regex.run(~r/(\d+)-(\d+) (\w): (\w+)/, policy)
    {String.to_integer(min), String.to_integer(max), char, password}
  end

  defp valid_policy1?({min, max, char, password}) do
    count = String.graphemes(password) |> Enum.count(&(&1 == char))
    count >= min and count <= max
  end

  defp valid_policy2?({pos1, pos2, char, password}) do
    String.at(password, pos1 - 1) == char != (String.at(password, pos2 - 1) == char)
  end
end
