defmodule Mix.Tasks.PerfectSquareComputer do                                  #Core logic computer module
  use GenServer
 
 def start_link() do
  GenServer.start_link(__MODULE__, [])
 end

 def init(each_num) do
    {:ok, each_num}
  end
 
 def handle_call({:async_number, each_n, arg_k}, _from, state) do              #Using mathematical equation
  a = each_n + arg_k - 1                                                       #Sum of squares of N consecutive numbers = n(n+1)(2n+1)/6
  b = each_n - 1 
  sum_square_k = (a * (a + 1) * (2 * a + 1)) / 6
  sum_square_i = (b * (b + 1) * (2 * b + 1))/6
  sum_final = sum_square_k - sum_square_i
  sqrt_sum_final = :math.sqrt(sum_final)
  roundedsqrt_sum_final = Kernel.trunc(sqrt_sum_final)
  if (roundedsqrt_sum_final == sqrt_sum_final) do                             #check if the sum is a perfect square and print the first number of sequence
    IO.puts "#{each_n}"
  end
  {:reply, arg_k, state}
 end
end

