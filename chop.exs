defmodule Chop do
  def guess(correct, start..finish),
    do:
      (
        guess = gethalfway(start..finish)
        IO.puts("Is it #{guess}")
        isit(correct, start..finish, guess)
      )

  def isit(correct, _, guess) when correct == guess, do: IO.puts(guess)

  def isit(correct, start.._, guess) when correct < guess do
    guess(correct, start..guess)
  end

  def isit(correct, _..finish, guess) when correct > guess do
    guess(correct, guess..finish)
  end

  def gethalfway(a..b), do: div(b + a, 2)
end
