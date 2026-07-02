# 🗺️ Automated Planning Practicals (PDDL)

A collection of **PDDL (Planning Domain Definition Language)** domains and problems developed for
the Planning course at UPC, solved with classical planners (Metric-FF). Covers deterministic
planning with typing, ADL and numeric fluents across several real-world-inspired scenarios.

## 📂 Scenarios

| Folder | Scenario | Highlights |
|---|---|---|
| `ascensor/` | Elevator scheduling (MICONIC benchmark) | Classic multi-floor passenger pickup/drop-off planning |
| `smartbus/` | Smart public-bus routing | Seat capacity + reduced-mobility seats modeled as numeric fluents; two domain versions (`v0`, `v2`) comparing fluent-based vs. simpler formulations |
| `tsp/` | Traveling Salesman as a planning problem | Encodes route optimization as goal-directed planning |
| `ext1`–`ext4` | Domain extensions | Incremental extensions of a base domain with new actions/predicates and multiple test problems |
| `prova/` | Sandbox domain/problem | Scratch domain used for testing the planner setup |

## ⚙️ How it works

Each scenario provides a **domain file** (`domain.pddl` / `*-domain-*.pddl`) describing the
predicates, functions and actions available, and one or more **problem files**
(`problem*.pddl`) describing a specific initial state and goal. The planner searches for a
sequence of actions (a plan) that transforms the initial state into a state satisfying the goal —
minimizing plan cost where numeric fluents are used (e.g. `smartbus`).

`genProblemes.py` programmatically generates randomized PDDL problem instances for stress-testing
the domains at different sizes.

## 🚀 How to run

Requires a PDDL planner such as [Metric-FF](https://fai.cs.uni-saarland.de/hoffmann/metric-ff.html)
(a precompiled Windows binary, `metricff.exe`, is included for convenience; on Linux/macOS build
Metric-FF from source or use an equivalent planner such as Fast Downward).

```bash
# Example: solve the elevator scenario
./ff -o ascensor/miconic.pddl -f ascensor/miconic01.pddl

# Example: solve the SmartBus scenario (numeric fluents)
./metricff -o smartbus/SmartBus-domain-fluents-v2.pddl -f smartbus/SmartBus-prob1-fluents-v2.pddl
```

Generate new random problem instances:

```bash
python3 genProblemes.py
```

## 🧰 Tech stack

PDDL (typing, ADL, numeric fluents) · Metric-FF planner · Python (problem generation)

## 📁 Repository structure

```
ascensor/        Elevator scheduling domain + 5 problem instances
smartbus/        Smart bus routing domain (2 fluent modeling versions) + problem
tsp/             TSP-as-planning domain/problem
ext1..ext4/      Progressive domain extensions with multiple test problems
prova/           Sandbox domain
genProblemes.py  Random PDDL problem generator
PracticaPlanificacion.pdf   Assignment write-up / report
```

## 👥 Author

José Durán — Automated Planning course, UPC.
