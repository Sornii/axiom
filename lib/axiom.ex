defmodule Axiom do
  use Bitwise

  defstruct bits: 0, alphabet: [], letter_size: 0, alphabet_size: 0

  defp size_of_letter(alphabet) do
    log = :math.log2(length(alphabet) + 1)
    if :math.fmod(log, 1) > 0 do
      trunc(log) + 1
    else
      trunc(log)
    end
  end

  defp is_eq(a, b) do
    a == b
  end

  def new(alphabet) when
        is_list(alphabet) and
        length(alphabet) > 0 do
    %Axiom{
      alphabet: alphabet,
      letter_size: size_of_letter(alphabet),
      alphabet_size: length(alphabet)
    }
  end

  def new(_) do
    raise "cannot create an axiom without an alphabet"
  end

  def add(%Axiom{bits: bits, letter_size: letter_size, alphabet: alphabet, alphabet_size: alphabet_size} = axiom, letter) when
        is_integer(letter) and letter > alphabet_size do
    letter = Enum.find_index(alphabet, &is_eq(&1, letter)) + 1
    %Axiom{
      axiom |
      bits: (
        bits
        <<< letter_size) + letter
    }
  end

  def add(%Axiom{bits: bits, letter_size: letter_size} = axiom, letter) when
        is_integer(letter) do
    IO.inspect axiom
    IO.inspect letter
    %Axiom{
      axiom |
      bits: (
        bits
        <<< letter_size) + letter
    }
  end

  def add(%Axiom{} = axiom, letters) when
        is_list(letters) and
        length(letters) > 0 do
    Enum.reduce(letters, axiom, &add(&2, &1))
  end

end