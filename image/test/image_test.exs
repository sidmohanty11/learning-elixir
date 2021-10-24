defmodule ImageTest do
  use ExUnit.Case
  doctest Image

  test "greets the world" do
    assert Image.hello() == :world
  end
end
