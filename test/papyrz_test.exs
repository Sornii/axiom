defmodule PapyrzTest do
  use ExUnit.Case
  doctest Papyrz

  test "greets the world" do
    assert Papyrz.hello() == :world
  end
end
