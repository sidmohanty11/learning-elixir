defmodule Cards do
  def create_deck do
    # create a deck
    values = [
      "Ace",
      "Two",
      "Three",
      "Four",
      "Five",
      "Six",
      "Seven",
      "Eight",
      "Nine",
      "Ten",
      "Jack",
      "Queen",
      "King"
    ]

    suits = ["Spades", "Clubs", "Hearts", "Diamonds"]

    for suit <- suits, value <- values do
      "#{value} of #{suit}"
    end
  end

  def shuffle(deck) do
    # shuffle the deck
    Enum.shuffle(deck)
  end

  def contains?(deck, card) do
    # (if present or not)
    Enum.member?(deck, card)
  end

  def deal(deck, hand_size) do
    # deal cards
    {hand, _} = Enum.split(deck, hand_size)
    hand
  end

  def save(deck, filename) do
    # Save on filesystem
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end

  def load(filename) do
    case File.read(filename) do
      {:ok, binary} -> :erlang.binary_to_term(binary)
      {:error, reason} -> "That file does not exist, #{reason}"
    end
  end
end
