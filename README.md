# Conjecturing.jl


[![Code Style: Blue](https://img.shields.io/badge/code%20style-blue-4495d1.svg)](https://github.com/invenia/BlueStyle)
[![ColPrac: Contributor's Guide on Collaborative Practices for Community Packages](https://img.shields.io/badge/ColPrac-Contributor's%20Guide-blueviolet)](https://github.com/SciML/ColPrac)
<!-- [![PkgEval](https://JuliaCI.github.io/NanosoldierReports/pkgeval_badges/G/GraphInvariants.svg)](https://JuliaCI.github.io/NanosoldierReports/pkgeval_badges/report.html) -->

## Overview
Conjecturing.jl is general automated conjecturing package currently in development that gives users the ability to produce conjectured relationships between invariants on a given type of mathematical object. To make conjectures you will need a ```data.csv``` file of precomputed invariant (and boolean data if you wish) data. The columns of ```data.csv``` should be the names of the invariants together with any optional boolean property names; exactly one column called "name" containing the names of each instance of the objects is also required.

The rows of ```data.csv``` are the instances of your objects. As an example, this package comes with precomputed example databases of mathematical values. This data is stored in the ```graph_data.csv``` file, the ```matrix_data.csv``` file, and the ```integer_data.csv``` file. These file contain precomputed numerical and boolean values on simple connected graphs, square matrices, and positive integers, respectively. Please see the examples directory for scripts conjecturing on each of these small datasets.


## Installation
Currently, *Conjecturing.jl* is not a registered Julia package. However, you may install it with the Julia package manager by running:

```Julia
pkg> add https://github.com/RandyRDavila/Conjecturing.jl

```

## Quick Start Example: Conjecturing on Graphs
To make a random conjecture on the graph data provided in this repository, copy and paste the following code into the julia REPL:
```julia
julia> using Conjecturing
julia> graph_types = Dict(
            :domination_number => Int,
            :total_domination_number => Int,
            :connected_domination_number => Int,
            :independence_number => Int,
            :zero_forcing_number => Int,
            :diameter => Int,
            :radius => Int,
            :order => Int,
            :independent_domination_number => Int,
            :chromatic_number => Int,
            :matching_number => Int,
            :min_maximal_matching_number => Int,
            :triameter => Int,
            :min_degree => Int,
            :max_degree => Int,
            :clique_number => Int,
            :residue => Int,
            :annihilation_number => Int,
            :vertex_cover_number => Int,
            :density => Float64,
            :algebraic_connectivity => Float64,
            :k_slater_index => Int,
            :k_residual_index => Int,
            :slater => Int,
            :sub_total_domination_number => Int,
            :two_residue => Float64,
            :number_of_degree_one_nodes => Int,
            :average_degree => Float64,
            :number_of_min_degree_nodes => Int,
            :number_of_max_degree_nodes => Int,
            :bipartite => Bool,
            :eulerian => Bool,
            :planar => Bool,
            :regular => Bool,
            :cubic => Bool,
            :not_K_n => Bool,
            :triangle_free => Bool,
            :claw_free => Bool,
            :a_tree => Bool,
            :at_free => Bool,
            :has_bridges => Bool,
            :chordal => Bool,
            :two_edge_connected => Bool,
            :distance_regular => Bool,
            :strongly_regular => Bool,
            :semieulerian => Bool,
            :bull_free => Bool,
            :complete_graph => Bool,
            :sub_cubic => Bool,
            :name => String,
            :paired_domination_number => Int,
            :power_domination_number => Int,
            :two_power_domination_number => Int,
            :two_domination_number => Int,
            :two_forcing_number => Int,
            :total_forcing_number => Int,
            :independence_number_squared => Int,
            :residue_squared => Int,
            :residue_equals_independence_number => Bool,
            :independence_number_equals_independent_domination_number =>Bool,
        )
julia> random_conjecture(
            "examples/data/new_graph_data.csv",
            "connected graph",
            types = new_graph_types,
            print_only = true,
            conj_lims = 1:60
        );
```

To make a conjecture on the *zero forcing number* of a graph on the graph data provided in this repository, copy and paste the following code into the julia REPL:
```julia
julia> using Conjecturing
julia> graph_types = Dict(
            :domination_number => Int,
            :total_domination_number => Int,
            :connected_domination_number => Int,
            :independence_number => Int,
            :zero_forcing_number => Int,
            :diameter => Int,
            :radius => Int,
            :order => Int,
            :independent_domination_number => Int,
            :chromatic_number => Int,
            :matching_number => Int,
            :min_maximal_matching_number => Int,
            :triameter => Int,
            :min_degree => Int,
            :max_degree => Int,
            :clique_number => Int,
            :residue => Int,
            :annihilation_number => Int,
            :vertex_cover_number => Int,
            :density => Float64,
            :algebraic_connectivity => Float64,
            :k_slater_index => Int,
            :k_residual_index => Int,
            :slater => Int,
            :sub_total_domination_number => Int,
            :two_residue => Float64,
            :number_of_degree_one_nodes => Int,
            :average_degree => Float64,
            :number_of_min_degree_nodes => Int,
            :number_of_max_degree_nodes => Int,
            :bipartite => Bool,
            :eulerian => Bool,
            :planar => Bool,
            :regular => Bool,
            :cubic => Bool,
            :not_K_n => Bool,
            :triangle_free => Bool,
            :claw_free => Bool,
            :a_tree => Bool,
            :at_free => Bool,
            :has_bridges => Bool,
            :chordal => Bool,
            :two_edge_connected => Bool,
            :distance_regular => Bool,
            :strongly_regular => Bool,
            :semieulerian => Bool,
            :bull_free => Bool,
            :complete_graph => Bool,
            :sub_cubic => Bool,
            :name => String,
            :paired_domination_number => Int,
            :power_domination_number => Int,
            :two_power_domination_number => Int,
            :two_domination_number => Int,
            :two_forcing_number => Int,
            :total_forcing_number => Int,
            :independence_number_squared => Int,
            :residue_squared => Int,
            :residue_equals_independence_number => Bool,
            :independence_number_equals_independent_domination_number =>Bool,
        )
julia> conjecture(
            "examples/data/new_graph_data.csv",
            "zero_forcing_number",
            "connected graph",
            types = new_graph_types,
            print_only = true,
            conj_lims = 1:60
        );
```

The output of this code should look like the following; note that the conjectures are listed in order of conjecture "strength". The conjectures at the top are considered "stronger" than the ones that follow.
```bash
   ______              _           __             _                 _ __
  / ____/___  ____    (_)__  _____/ /___  _______(_)___  ____ _    (_) /
 / /   / __ \/ __ \  / / _ \/ ___/ __/ / / / ___/ / __ \/ __ `/   / / /
/ /___/ /_/ / / / / / /  __/ /__/ /_/ /_/ / /  / / / / / /_/ /   / / /
\____/\____/_/ /_/_/ /\___/\___/\__/\__,_/_/  /_/_/ /_/\__, (_)_/ /_/
                /___/                                 /____/ /___/

-----------------------------------------------
Version  0.1.0
Copyright 2022 Randy Davila and David Amos
-----------------------------------------------

Conjecture 1. If X is a connected graph and is chordal, then zero_forcing_number(X) ≤ number_of_degree_one_nodes(X) + -1//1.
touch number = 86

Conjecture 2. If X is a connected graph, then zero_forcing_number(X) ≥ min_degree(X).
touch number = 49

Conjecture 3. If X is a connected graph and is regular, then zero_forcing_number(X) ≥ 1//3*order(X).
touch number = 47

Conjecture 4. If X is a connected graph, then zero_forcing_number(X) ≥ 1//3*number_of_min_degree_nodes(X).
touch number = 47

Conjecture 5. If X is a connected graph and is regular, then zero_forcing_number(X) ≥ 1//3*number_of_max_degree_nodes(X).
touch number = 47

Conjecture 6. If X is a connected graph and is cubic, then zero_forcing_number(X) ≤ 4//5*total_forcing_number(X) + 1//1.
touch number = 36

Conjecture 7. If X is a connected graph and is residue_equals_independence_number, then zero_forcing_number(X) ≤ number_of_degree_one_nodes(X) + -1//1.
touch number = 31

Conjecture 8. If X is a connected graph and is has_bridges, then zero_forcing_number(X) ≥ 1//2*number_of_min_degree_nodes(X).
touch number = 30

Conjecture 9. If X is a connected graph, then zero_forcing_number(X) ≥ k_slater_index(X).
touch number = 28

Conjecture 10. If X is a connected graph, then zero_forcing_number(X) ≥ 1//2*number_of_degree_one_nodes(X).
touch number = 27

Conjecture 11. If X is a connected graph and is chordal, then zero_forcing_number(X) ≥ 1//2*number_of_min_degree_nodes(X).
touch number = 27

Conjecture 12. If X is a connected graph, then zero_forcing_number(X) ≥ 1//2*total_forcing_number(X).
touch number = 27

Conjecture 13. If X is a connected graph, then zero_forcing_number(X) ≥ power_domination_number(X).
touch number = 26

Conjecture 14. If X is a connected graph and is sub_cubic, then zero_forcing_number(X) ≤ 3//2*number_of_max_degree_nodes(X) + 1//2.
touch number = 23

Conjecture 15. If X is a connected graph and is semieulerian, then zero_forcing_number(X) ≥ 1//2*max_degree(X).
touch number = 20

Conjecture 16. If X is a connected graph and is claw_free, then zero_forcing_number(X) ≤ vertex_cover_number(X).
touch number = 20

Conjecture 17. If X is a connected graph and is claw_free, then zero_forcing_number(X) ≥ 1//2*max_degree(X).
touch number = 19

Conjecture 18. If X is a connected graph and is independence_number_equals_independent_domination_number, then zero_forcing_number(X) ≥ min_maximal_matching_number(X).
touch number = 17

Conjecture 19. If X is a connected graph and is regular, then zero_forcing_number(X) ≥ max_degree(X).
touch number = 17

Conjecture 20. If X is a connected graph and is has_bridges, then zero_forcing_number(X) ≥ 1//2*max_degree(X).
touch number = 17

Conjecture 21. If X is a connected graph and is regular, then zero_forcing_number(X) ≥ average_degree(X).
touch number = 17

Conjecture 22. If X is a connected graph, then zero_forcing_number(X) ≥ 1//2*chromatic_number(X).
touch number = 15

Conjecture 23. If X is a connected graph and is triangle_free, then zero_forcing_number(X) ≥ 1//2*max_degree(X).
touch number = 15

Conjecture 24. If X is a connected graph and is sub_cubic, then zero_forcing_number(X) ≥ 1//2*max_degree(X).
touch number = 15

Conjecture 25. If X is a connected graph, then zero_forcing_number(X) ≥ 1//2*clique_number(X).
touch number = 15

Conjecture 26. If X is a connected graph and is semieulerian, then zero_forcing_number(X) ≥ 1//2*number_of_min_degree_nodes(X).
touch number = 15

Conjecture 27. If X is a connected graph, then zero_forcing_number(X) ≥ two_power_domination_number(X).
touch number = 15

Conjecture 28. If X is a connected graph, then zero_forcing_number(X) ≥ two_forcing_number(X).
touch number = 15

Conjecture 29. If X is a connected graph and is eulerian, then zero_forcing_number(X) ≥ total_forcing_number(X).
touch number = 14

Conjecture 30. If X is a connected graph and is distance_regular, then zero_forcing_number(X) ≥ total_forcing_number(X).
touch number = 14

Conjecture 31. If X is a connected graph and is sub_cubic, then zero_forcing_number(X) ≤ 3//2*min_maximal_matching_number(X) + 1//2.
touch number = 13

Conjecture 32. If X is a connected graph and is regular, then zero_forcing_number(X) ≥ radius(X).
touch number = 12

Conjecture 33. If X is a connected graph and is planar, then zero_forcing_number(X) ≤ annihilation_number(X) + 1//1.
touch number = 12

Conjecture 34. If X is a connected graph and is claw_free, then zero_forcing_number(X) ≤ 3//2*total_domination_number(X) + 1//1.
touch number = 11

Conjecture 35. If X is a connected graph, then zero_forcing_number(X) ≥ 1//2*k_residual_index(X).
touch number = 11

Conjecture 36. If X is a connected graph and is claw_free, then zero_forcing_number(X) ≤ 3//2*paired_domination_number(X) + 1//1.
touch number = 11

Conjecture 37. If X is a connected graph and is regular, then zero_forcing_number(X) ≥ residue(X).
touch number = 9

Conjecture 38. If X is a connected graph and is two_edge_connected, then zero_forcing_number(X) ≥ k_residual_index(X).
touch number = 9

Conjecture 39. If X is a connected graph and is regular, then zero_forcing_number(X) ≥ slater(X).
touch number = 9

Conjecture 40. If X is a connected graph and is two_edge_connected, then zero_forcing_number(X) ≤ 1//3*number_of_degree_one_nodes(X) + 6//1.
touch number = 9

Conjecture 41. If X is a connected graph and is cubic, then zero_forcing_number(X) ≥ 3//1*two_power_domination_number(X).
touch number = 9

Conjecture 42. If X is a connected graph and is sub_cubic, then zero_forcing_number(X) ≤ two_domination_number(X) + 1//1.
touch number = 9

Conjecture 43. If X is a connected graph and is cubic, then zero_forcing_number(X) ≥ 3//2*two_forcing_number(X).
touch number = 9

Conjecture 44. If X is a connected graph and is two_edge_connected, then zero_forcing_number(X) ≥ 4//3*two_forcing_number(X).
touch number = 9

Conjecture 45. If X is a connected graph and is semieulerian, then zero_forcing_number(X) ≤ 1//2*order(X) + 1//2.
touch number = 8

Conjecture 46. If X is a connected graph and is regular, then zero_forcing_number(X) ≥ 1//2*vertex_cover_number(X).
touch number = 8

Conjecture 47. If X is a connected graph and is eulerian, then zero_forcing_number(X) ≥ average_degree(X).
touch number = 8

Conjecture 48. If X is a connected graph and is independence_number_equals_independent_domination_number, then zero_forcing_number(X) ≥ 1//2*paired_domination_number(X).
touch number = 8

Conjecture 49. If X is a connected graph and is two_edge_connected, then zero_forcing_number(X) ≤ 7//2*two_power_domination_number(X) + 5//2.
touch number = 8

Conjecture 50. If X is a connected graph and is two_edge_connected, then zero_forcing_number(X) ≥ 1//3*triameter(X).
touch number = 7

Conjecture 51. If X is a connected graph and is independence_number_equals_independent_domination_number, then zero_forcing_number(X) ≥ 1//2*vertex_cover_number(X).
touch number = 7

Conjecture 52. If X is a connected graph and is claw_free, then zero_forcing_number(X) ≤ 2//1*number_of_max_degree_nodes(X) + 1//1.
touch number = 7

Conjecture 53. If X is a connected graph and is two_edge_connected, then zero_forcing_number(X) ≥ 2//1*two_power_domination_number(X).
touch number = 7

Conjecture 54. If X is a connected graph and is claw_free, then zero_forcing_number(X) ≤ 3//2*two_domination_number(X) + 1//1.
touch number = 7

Conjecture 55. If X is a connected graph and is residue_equals_independence_number, then zero_forcing_number(X) ≤ 3//2*two_domination_number(X) + 1//1.
touch number = 7

Conjecture 56. If X is a connected graph and is independence_number_equals_independent_domination_number, then zero_forcing_number(X) ≤ 3//2*two_domination_number(X) + 1//1.
touch number = 7

Conjecture 57. If X is a connected graph and is claw_free, then zero_forcing_number(X) ≤ 2//1*two_forcing_number(X) + 1//1.
touch number = 7

Conjecture 58. If X is a connected graph and is residue_equals_independence_number, then zero_forcing_number(X) ≤ 2//1*two_forcing_number(X) + 1//1.
touch number = 7

Conjecture 59. If X is a connected graph and is two_edge_connected, then zero_forcing_number(X) ≥ 2//3*chromatic_number(X).
touch number = 6

Conjecture 60. If X is a connected graph and is two_edge_connected, then zero_forcing_number(X) ≤ 5//2*clique_number(X) + 1//1.
touch number = 6
```


## Basic use

If you would like to conjecture on a specific column contained in your ```data.csv``` file:

```Julia
conjs = conjecture(
    "data.csv",
    "<name of invariant to conjecture on>",
    "<name of the type of object>",
    types = types_of_obects_values, # A dictionary (see examples directory)
)

```

If you would like to conjecture on a random column contained in your ```data.csv``` file:

```Julia
random_conjs = random_conjecture(
    "data.csv",
    "<name of the type of object>",
    types = types_of_obects_values, # A dictionary (see examples directory)
)
```


