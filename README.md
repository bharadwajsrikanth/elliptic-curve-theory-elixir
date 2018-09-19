# elliptic-curve-theory
Finding perfect squares that are sums of consecutive squares.


## 1 Logistics

## 1.1 How to run

1. Unzip the file in a directory and navigate to the directory.
2. Run cd on your terminal to navigate into project folder.
3. Run the mix command as follows to execute the project.
    mix runner N k
    Ex:mix runner 100 24

## 2 Implementation Details

## 2.1 Algorithm

Given a starting number ‘i’, the naive brute force approach is to calculate square of all number
starting from ‘i’ till ‘k’, summing them up and then checking if the result is a perfect square. This
logic is slow as for ‘i+1’ it involves computing sub-problems which have already been computed for
number ‘i’.

We have optimized the solution.

Sum of squares of k natural numbers starting from 1:

```
1^2 + 2^2 +....+k^2 = (k(k+ 1)(2k+ 1)/6) - (0^2 )

```
#### 

Sum of square of k natural numbers starting from 2:

```
2^2 + 3^2 +....+ (k+ 1)^2 = (k+ 1)(k+ 2)(2k+ 3)/6
```

#### 


Sum of square of k natural numbers starting from 3:

```
3^2 + 4^2 +....+ (k+ 2)^2 = ((k+ 2)(k+ 3)(2k+ 5)/6) −(1^2 + 2^2 )
```
#### 

The term which is getting subtracted can be derived from the sum of squares formula.
Generalizing the above to get:

Sum of square of k natural numbers starting from i:

```
i^2 + (i+ 1)^2 +....+ (k+i−1)^2 = ((k+i−1)(k+i)(2k+ 2i−1)/6) - (i−1)(i)(2i−1)/6
∀i∈{ 1 , .., n}
```


The above formula gives as an optimized solution to the problem. Instead of calculating squares
of k numbers for each iteration, we are using the multiplication operation fixed number of times,
which is a constant irrespective of the size of k.

### 2.2 Size of the work unit

In a single request from the boss, each worker gets assigned a number between one and n for
which it will compute the above formula.

We approached this work size by doing an experiment. We incrementally spawned workers and
calculated the time. For sample size of n = 1000, k = 24, we observed as the number of workers
increased the overall time taken to compute results decreased. However, there was little difference
in the total time after 100 workers. Since, in Elixir actors have little overhead and in our
optimized solution there is no state preservation required, we are spawning ’n’ instances of the
worker, each solving one sub-problem.


### 2.3 CPU Utilization: Ratio of CPU time to REAL TIME

Result of running the program with n=1000000 and k=4 on 4-core Intel i7 processor.

Total CPU Time = 29.167s + 21.574s = 50.741s
Total Real Time = 13.241s
The ratio of CPU to Real Time =3.

### 2.4 Largest problem we solved

Since we optimized our solution, the running time of the algorithm only depends on the input ’N’.
The input ’k’ doesn’t affect our running time and is treated as a constant.

Hence, the largest problem we solved is N=100000000 (100 million) with k = 24.
Note: Since we optimized our solution, it is independent of the value of k.

The output is saved in the file namedoutputmaxononesys.txtin harkiratsrikanth
directory.

## 3 Distribution across multiple machines

### 3.1 Machine Setup and How to run

- On remote machine
    1. Unzip the file in a directory and navigate to that directory.
    2. Enter the following commands to navigate to tasks directory.
       cd lib/mix/tasks


3. Enter the following command to set alias name and cookie for authentication between
    multiple systems:
    iex –name alias-name@ipaddress –cookie niche –erl ”+P 100000000”
    Ex: iex –name spiderman@10.136.49.119 –cookie niche –erl ”+P
    100000000”
4. Run iex shell by running following:
    iex
5. Run the following command to load the core logic module in the remote system
    c(“remoteboss.ex”)
    c(“perfect_square_computer.ex”)
- On local machine
1. Unzip the file in a directory and navigate to that directory.
2. Go to lib - mix - tasks.
3. Open distributed_boss.ex in Notepad++ (or any other editor) to specify the
remotemachines.
4. Enter the remote machine to be connected in the remotemachines list (on line number
7) in the format shown in the file.
5. Runcd harkiratsrikanthon your terminal to navigate into project folder.
6. Run the following command to execute the program.
time elixir –erl ”+P 100000000” -S mix distributed.runner N k –no-halt
Ex: time elixir –erl ”+P 100000000” -S mix distributed.runner 100000000
20 –no-halt
7. In case the above command is not executed, use the alternate command:
iex -S mix distributed.runner N k
Ex: iex -S mix distributed.runner 100000000 20




