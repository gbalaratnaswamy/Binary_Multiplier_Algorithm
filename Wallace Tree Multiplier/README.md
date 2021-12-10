# Wallace Tree Multiplier
This is a multiplier algorithm for signed numbers. It tries to 

This contains many files
main.v -> combinatinal implemetation of Wallace multiplier.
pipelined.v -> implemenst pipelinig to Wallace multiplier.

## Test bench
t_main.v -> uses all possible combinations and count the number of errors (missmatched values) at end.

As expected I got 0 errors.




t_pipelined.v ->  uses all possible combinations and wait for appropiate time and count the number of errors (missmatched values) at end. 

As expected I got 0 errors.

## Reference
[Wikipedia](https://en.wikipedia.org/wiki/Wallace_tree)