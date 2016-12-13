defmodule Words do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t) :: map
  def count(sentence) do
    sentence
    |> String.split([" ", ", ", ",", "_"])
    |> Enum.map(&String.downcase(&1))
    |> Enum.map(&clean_string(&1))
    |> count(%{})
  end
  def count([], result), do: result
  def count([head | tail], result) do
    if head, do: count(tail, add_to_result(result, head)), else: count(tail, result)
  end

  defp add_to_result(result, index) do
    case Map.get(result, index) do
      nil -> Map.put(result, index, 1)
      _ -> Map.update!(result, index, &(&1 + 1))
    end
  end

  defp clean_string(string) do
    if string =~ ~r/^[\p{L}\p{Nd}-]/ do
      String.codepoints(string) |> trim_word |> to_string
    else
      nil
    end
  end

  defp trim_word(phrase), do: trim_word(phrase, [])
  defp trim_word([], result), do: result
  defp trim_word([head | tail], result) do

    if head =~ ~r/^[\p{L}\p{Nd}-]/, do: trim_word(tail, result ++ [head]), else: trim_word(tail, result)
  end
end
