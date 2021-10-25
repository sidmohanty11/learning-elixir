defmodule Image do
  @moduledoc """
  IMAGICON
  """
  def main(input) do
    input
    |> hash_input()
    |> pick_color()
    |> build_grid()
    |> filter_odd_squares()
    |> build_pixel_map()
    |> draw_image()
    |> save_image(input)
  end

  def save_image(image, filename) do
    File.write("identicons/#{filename}.png", image)
  end

  def draw_image(%Image.Identicon{color: color, pixel_map: pixel_map}) do
    image = :egd.create(250, 250)
    fill = :egd.color(color)

    Enum.each(pixel_map, fn {start, stop} ->
      :egd.filledRectangle(image, start, stop, fill)
    end)

    :egd.render(image)
  end

  def pick_color(%Image.Identicon{hex: [r, g, b | _rest]} = image) do
    %Image.Identicon{image | color: {r, g, b}}
  end

  def build_pixel_map(%Image.Identicon{grid: grid} = image) do
    pixel_map =
      Enum.map(grid, fn {_hex, index} ->
        horizontal = rem(index, 5) * 50
        vertical = div(index, 5) * 50
        top_left = {horizontal, vertical}
        bottom_right = {horizontal + 50, vertical + 50}

        {top_left, bottom_right}
      end)

    %Image.Identicon{image | pixel_map: pixel_map}
  end

  @spec hash_input(any) :: %Image.Identicon{color: nil, grid: nil, hex: [byte]}
  def hash_input(input) do
    hex =
      :crypto.hash(:md5, input)
      |> :binary.bin_to_list()

    %Image.Identicon{hex: hex}
  end

  def build_grid(%Image.Identicon{hex: hex_list} = image) do
    grid =
      hex_list
      |> Enum.chunk(3)
      |> Enum.map(&mirror_row/1)
      |> List.flatten()
      |> Enum.with_index()

    %Image.Identicon{image | grid: grid}
  end

  def filter_odd_squares(%Image.Identicon{grid: grid} = image) do
    grid =
      Enum.filter(grid, fn {code, _idx} ->
        rem(code, 2) == 0
      end)

    %Image.Identicon{image | grid: grid}
  end

  def mirror_row(row) do
    # [1,4,5] => [1,4,5,4,1]
    [f, s | _tail] = row
    row ++ [s, f]
  end
end
