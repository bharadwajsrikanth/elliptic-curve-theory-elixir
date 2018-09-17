defmodule Mix.Tasks.Boss do                                                          #BOSS module, creating and managing parallel processes
  
  def start_link(arg_n, arg_k) do
    {:ok, pid} = Mix.Tasks.PerfectSquareComputer.start_link()                        #Start core logic module
    (1..arg_n)
    |> Enum.map(fn(each_n) -> spawn(__MODULE__, :work, [pid, each_n, arg_k]) end)    #spawn multiple process running in parallel
  end

  def work(pid, each_n, arg_k) do
    GenServer.call(pid, {:async_number, each_n, arg_k})                                             #call core logic to compute solution
  end

end
