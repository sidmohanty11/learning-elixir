defmodule Cards do
  @moduledoc """
    Provides methods for creating and handling a deck of cards!
  """

  @doc """
  Returns a list of strings representing a deck of playing cards
  """
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

  @doc """
    shuffle the deck
  """
  def shuffle(deck) do
    # shuffle the deck
    Enum.shuffle(deck)
  end

  @doc """
    if the card is present in the deck

  ## Examples

      iex> deck = Cards.create_deck()
      iex> Cards.contains?(deck, "Ace of Spades")
      true

  """
  def contains?(deck, card) do
    # (if present or not)
    Enum.member?(deck, card)
  end

  @doc """
  Uses pattern matching => splits the deck into hand and rest of the cards
  The `hand_size` arg indicates how many cards should you deal with

  ## Examples

      iex>deck = Cards.create_deck()
      iex>Cards.deal(deck, 1)
      ["Ace of Spades"]

  """
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

  def create_hand(hand_size) do
    # deck = Cards.create_deck()
    # deck = Cards.shuffle(deck)
    # hand = Cards.deal(deck, hand_size)

    Cards.create_deck()
    |> Cards.shuffle()
    |> Cards.deal(hand_size)
  end
end
