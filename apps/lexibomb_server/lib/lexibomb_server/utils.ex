defmodule LexibombServer.Utils do
  @moduledoc """
  Helper utilities used throughout LexibombServer.
  """

  @top_line_set    {"┌", "┬", "┐"}
  @middle_line_set {"├", "┼", "┤"}
  @bottom_line_set {"└", "┴", "┘"}

  @spec draw_grid_line(pos_integer, :top | :middle | :bottom, pos_integer) :: String.t
  def draw_grid_line(count, line_set, item_width \\ 3)
  def draw_grid_line(count, :top, item_width) do
    do_draw_grid_line(count, @top_line_set, item_width)
  end
  def draw_grid_line(count, :middle, item_width) do
    do_draw_grid_line(count, @middle_line_set, item_width)
  end
  def draw_grid_line(count, :bottom, item_width) do
    do_draw_grid_line(count, @bottom_line_set, item_width)
  end

  @spec do_draw_grid_line(pos_integer, {String.t, String.t, String.t}, pos_integer) :: String.t
  defp do_draw_grid_line(count, line_set, item_width)
  defp do_draw_grid_line(1, line_set, item_width) do
    first = elem(line_set, 0)
    last  = elem(line_set, 2)
    spacer = String.duplicate("─", item_width)

    Enum.join([first, spacer, last])
  end
  defp do_draw_grid_line(count, line_set, item_width) do
    first = elem(line_set, 0)
    inner = elem(line_set, 1)
    last  = elem(line_set, 2)
    spacer = String.duplicate("─", item_width)

    middle = for _ <- 0..count-2, do: inner
    separators = [first] ++ middle ++ [last]

    Enum.join(separators, spacer)
  end

  @spec draw_segments([String.t], String.t) :: String.t
  def draw_segments(strings, sep \\ "│") do
    sep <> Enum.join(strings, sep) <> sep
  end

  @spec first_or_last?(non_neg_integer, non_neg_integer) :: boolean
  def first_or_last?(index, size) do
    first = 0
    last = size - 1

    case index do
      ^first -> true
      ^last -> true
      _ -> false
    end
  end

  @spec zero_pad(non_neg_integer, non_neg_integer) :: String.t
  def zero_pad(n, len) when is_integer(n) do
    n |> to_string |> String.rjust(len, ?0)
  end
end
