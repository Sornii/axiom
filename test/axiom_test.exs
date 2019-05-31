defmodule AxiomTest do
  use ExUnit.Case

  describe "Axiom.new/1" do
    axiom_new_io = [
      ['F', %{alphabet: 'F', letter_size: 1, alphabet_size: 1, bits: 0}],
      ['f', %{alphabet: 'f', letter_size: 1, alphabet_size: 1, bits: 0}],
      ['F+', %{alphabet: 'F+', letter_size: 2, alphabet_size: 2, bits: 0}],
      ['F+-', %{alphabet: 'F+-', letter_size: 2, alphabet_size: 3, bits: 0}],
      ['Ff+-', %{alphabet: 'Ff+-', letter_size: 3, alphabet_size: 4, bits: 0}],
      ['Ffi+-', %{alphabet: 'Ffi+-', letter_size: 3, alphabet_size: 5, bits: 0}],
    ]

    test "Axiom.new/1 expects a error" do
      assert catch_error(Axiom.new(''))
    end

    for [input, _] <- axiom_new_io do
      @input input
      test "Axiom.new/1 expects success using #{@input}" do
        assert Axiom.new(@input)
      end
    end

    for [input, output] <- axiom_new_io do
      @input input
      @output output
      test "Axiom.new/1 expects success and valid struct using #{@input}" do
        %{
          alphabet: alphabet,
          letter_size: letter_size,
          alphabet_size: alphabet_size,
          bits: bits
        } = @output

        assert %Axiom{
                 alphabet: ^alphabet,
                 letter_size: ^letter_size,
                 alphabet_size: ^alphabet_size,
                 bits: bits
               } = Axiom.new(@input)
      end
    end
  end

  describe "Axiom.add/2" do
    axiom = Axiom.new('F+-')

    axiom_add_list_io = [
      [axiom, 'F', 1],
      [axiom, 'F+', 6],
      [axiom, 'F+F', 25],
      [axiom, 'F+F+', 102],
      [axiom, 'F+F+F', 409],
      [axiom, 'F+F+F+F', 6553]
    ]

    test "Axiom.add/2 expects error" do
      assert catch_error(Axiom.add(Axiom.new('F+-'), ''))
    end

    for [axiom, input, bits] <- axiom_add_list_io do
      @axiom axiom
      @input input
      @bits bits
      test "Axiom.add/2 expects #{@bits} bits when adding #{@input}" do
        bits = @bits

        assert %Axiom{bits: ^bits} = Axiom.add(@axiom, @input)
      end
    end

  end
end
