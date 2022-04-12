defmodule MyList do
  # Sums entire list
  def mapsum([], _fun), do: 0
  def mapsum([head | tail], fun), do: fun.(head) + mapsum(tail, fun)

  # Returns maximum value from list
  def getmaxval(list, biggest \\ nil)
  def getmaxval([], biggest), do: biggest

  def getmaxval([head | tail], biggest)
      when is_nil(biggest) or head > biggest,
      do: getmaxval(tail, head)

  def getmaxval([head | tail], biggest) when biggest > head, do: getmaxval(tail, biggest)

  # An Elixir single-quoted string is actually a list of individual character
  # codes. Write a caesar(list, n) function that adds n to each list element,
  # wrapping if the addition results in a character greater than z.
  def caesar([], _), do: ''

  def caesar([head | tail], n) when is_integer(n) and head + n > ?z,
    do: [?a + head + n - ?z - 1 | caesar(tail, n)]

  def caesar([head | tail], n) when is_integer(n), do: [head + n | caesar(tail, n)]

  # Write a function MyList.span(from, to) that returns a list of the numbers
  # from from up to to.
  def span(from, to) when from > to, do: []

  def span(from, to), do: [from | span(from + 1, to)]

  # Implement the following Enum functions using no library functions or list
  # comprehensions: all?, each, filter, split, and take.
  def all?([]), do: true
  def all?([head | _]) when head in [false, nil], do: false
  def all?([_ | tail]), do: true and all?(tail)

  def each([], _), do: true

  def each([head | tail], fun) when is_function(fun),
    do:
      (
        fun.(head)
        each(tail, fun)
      )

  def filter([], _), do: []

  def filter([head | tail], fun) when is_function(fun),
    do:
      (if fun.(head) do
         [head | filter(tail, fun)]
       else
         filter(tail, fun)
       end)

  def split([], _), do: {[], []}
  def split([head | tail], n) when n == 0, do: {[], [head | tail]}

  def split([head | tail], n) when n > 0,
    do:
      (
        {first, second} = split(tail, n - 1)
        {[head | first], second}
      )

  def split([head | tail], n) when n < 0,
    do:
      (
        reverselist = reverse([head | tail])
        {first, second} = split(reverselist, abs(n))
        {second, first}
      )

  def reverse([head | tail]), do: reverse(tail) ++ [head]
  def reverse([]), do: []

  def take([], _), do: []
  def take(_, 0), do: []
  def take([head | tail], n) when n > 0, do: [head | take(tail, n - 1)]
  def take([head | tail], n) when n < 0, do: (
    reverselist = reverse([head | tail])
    take(reverselist, abs(n))
  )

  # Write a flatten(list) function that takes a list that may contain any number of sublists,
  # which themselves may contain sublists, to any depth. It returns the elements of these lists as a flat list.
  def flatten([]), do: []
  def flatten([head | tail]) when is_list(head), do: flatten(head) ++ flatten(tail)
  def flatten([head | tail]), do: [head | flatten(tail)]

  # In the last exercise of Chapter 7, Lists and Recursion, on page 71, you wrote a span function.
  # Use it and list comprehensions to return a list of the prime numbers from 2 to n.
  def primenumbers(n), do: (
    span(2, n)
    |> filter(&isprime(&1))
  )

  def isprime(n), do: (
    tests = for num <- n..2, into: [], do: rem(n, num) != 0 or num == n
    tests
    |> all?
  )
end
