#!/usr/bin/env python3

# N = 1500
OPT = 1 # Optimal cost, refactored to be 1.
import gurobipy as gp
from gurobipy import GRB

# gammas = [1.2, 1.25, 1.3, 1.35, 1.4, 1.425, 1.45, 1.475, 1.5, 1.525, 1.55, 1.575, 1.6, 1.7, 1.8, 1.9, 2.0, 2.1, 2.2, 2.3, 2.4, 2.5, 2.55, 2.6, 2.65, 2.7, 2.75, 2.8, 2.85, 2.86, 2.865, 2.866, 2.867, 2.868, 2.869, 2.87, 2.871, 2.872, 2.873, 2.874, 2.9, 3.0]

# only presentation set of gammas
# gammas = [2.0, 2.1, 2.2, 2.3, 2.4, 2.5, 2.55, 2.6, 2.65, 2.7, 2.75, 2.8, 2.85, 2.868, 2.87, 2.88, 2.9, 2.95,3, 3.05,3.1,3.2,3.3,4.0, 4.5, 5, 6]
# Ns = [100,500,1000, 1500]
gammas = [2.867]
Ns = [1600]
# completed

results = []
for N in Ns:
    ratios = []
    for GAMMA in gammas:
        print("Solving with n = " + str(N) + " and gamma " + str(GAMMA))
        m = gp.Model("facility-location-waiting")

        m.setParam("method",2)
        m.setParam("Crossover",0)

        service_times = []
        assignment_times = []
        waiting_times = []
        distances = []
        contributions = [] 
        # Adding variables as Gurobi's tuple-dicts to have more flexibility.

        service_times = m.addVars(range(N), lb=float('-inf'), name = "s")
        waiting_times = m.addVars(range(N), lb=0.0, name = "w")
        assignment_times = m.addVars(range(N), lb=float('-inf'), name = "a")

        distances = m.addVars(range(N), lb=0.0, name = "d")
        f = m.addVar(lb=0.0, name="f")
        # Helper two dimensional variable contributions.
        indices = [(i,j) for i in range(N) for j in range(N)]
        contributions = m.addVars(indices, lb=0.0, name = "c")

        # Objective.

        obj = gp.LinExpr()
        for i in range(N):
            obj.add(service_times[i], 1.0 + GAMMA)
            obj.add(assignment_times[i], -(1.0 + GAMMA))

        m.setObjective(obj, GRB.MAXIMIZE)

        # Adding constraints.

        # Optimal cost equals O (currently O = 1).
        m.addLConstr(waiting_times.sum() + distances.sum() + f, GRB.EQUAL, OPT, name="normalization")
        # w_i >= |a_i|
        for i in range(N):
            m.addLConstr(waiting_times[i], GRB.GREATER_EQUAL, assignment_times[i], name="wi_greater_ai" + str(i))
            m.addLConstr(waiting_times[i], GRB.GREATER_EQUAL, - assignment_times[i], name="wi_greater_abs_ai" + str(i))
        # Service times are ordered.
        for i in range(N-1):
            m.addLConstr(service_times[i+1], GRB.GREATER_EQUAL, service_times[i], name="service_order" + str(i))
        # s_i >= a_i.
        for i in range(N):
            m.addLConstr(service_times[i], GRB.GREATER_EQUAL, assignment_times[i], name="si_greater_ai" + str(i))
        # The strange triangle inequality.

        for i in range(N):
            for j in range(i+1, N):
                m.addLConstr((GAMMA-1.0)*service_times[j] - GAMMA*assignment_times[j], GRB.LESS_EQUAL,
                             (GAMMA-1.0)*service_times[i] - GAMMA*assignment_times[i] + distances[i] + distances[j])

        # Contributions constraints. First, its definition:
        for (l,i) in indices:
            m.addLConstr(contributions[(l,i)], GRB.GREATER_EQUAL, GAMMA*(service_times[l] - assignment_times[i]) - distances[i])

        # Now the constraint for f with the contribution variables.

        for l in range(N):
            left_side = gp.LinExpr()
            for i in range(l,N):
                left_side.add(contributions[l,i])
            m.addLConstr(left_side, GRB.LESS_EQUAL, f)

        m.optimize()
        ratios.append(m.objVal)

        # m.printQuality()
        # m.printStats()

        # Debugging print.
        # m.write("testmodel.lp")
    results.append(ratios)
print("--- lower bound results ---")
for j in range(len(Ns)):
    print("--- N = " + str(Ns[j]) + " ---")
    for i in range(len(gammas)):
        print(str(gammas[i]) + "," + str(results[j][i]))
