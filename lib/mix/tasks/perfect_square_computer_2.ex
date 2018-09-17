defmodule Mix.Tasks.PerfectSquareComputer do                                  #Core logic computer module
  use GenServer
 
 def start_link() do
  GenServer.start_link(__MODULE__, [])
 end

 def init(each_num) do
    {:ok, each_num}
  end
 
 def handle_call({:async_number, each_n, arg_k}, _from, state) do              #Using mathematical equation
  
  end_lit = each_n + arg_k-1

  sq_list = (each_n..end_lit) |> Enum.map(fn(i) -> i*i end)
  sum = Enum.sum(sq_list)
  sqrt_sum_final = :math.sqrt(sum)

  
  roundedsqrt_sum_final = Kernel.trunc(sqrt_sum_final)
  
  if (roundedsqrt_sum_final == sqrt_sum_final) do                             #check if the sum is a perfect square and print the first number of sequence
   IO.puts "#{each_n}"
  end
  {:reply, arg_k, state}
 end
end

