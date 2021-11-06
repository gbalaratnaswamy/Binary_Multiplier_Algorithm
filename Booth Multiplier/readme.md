# Booth Multiplier
This is a multiplier algorithm for signed numbers. This algorithm has low power requirements.

## Test bench
This testbench takes 33 as multiplicand and 20 as multiplier

After 10 clock cycles ( 1 for loading 8 for computing and 1 for stabilising answer) we get result as output.

product of 20 and 33 is 660 which is 0294 in Hexadeciaml

![Test Bench Result image](../images/booth_multiplier_2.png "Wave form")

From the Waveform we can see that result is as expected

## Reference
[Wikipedia](https://en.wikipedia.org/wiki/Booth%27s_multiplication_algorithm)