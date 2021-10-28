# fl-double-sided-waiting

In this repository, you can find a Python generator for a parametric factor revealing LP, as well as a select
few solutions of the LP based on certain parameters. This allows for easy verification of our computational
claims in a paper Online Facility Location with Linear Delay, currently in preparation.

## File list and comments:
File 1: solve-and-print-lp2.py

Comment: For a fixed N and GAMMA, this script calles Gurobi's Python interface
to provide both primal and dual solution, thus certifying optimality.

File 2: doubly-parametric-lp1.py

A generator that can test LP1 (from the paper) to find the best possible value among the preset
multiple choices of N and GAMMA. Again uses Gurobi's Python interface.

File 3: doubly-parametric-lp2.py

The same generator with a list of values for N and GAMMA, but for LP2.

File 4: curve-tightening.R

Visualization of the data obtained from the generators doubly-parametric-lp1.py and doubly-parametric-lp2.py.

File 5: optimalsolution-3869.txt.xz

A primal and dual solution provided by solve-and-print-lp2.py. Equivalent to a proof that the optimal value
of LP2 is approximately 3.869 for N = 1500 and GAMMA = 2.869.
 
Code author: Martin Böhm

Paper authors: Marcin Bienkowski, Martin Böhm, Jaroslaw Byrka, Jan Marcinkowski

A link to the paper will be provided when a public abstract is available.
