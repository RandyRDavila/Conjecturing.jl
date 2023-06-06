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
julia>  graph_types = Dict(
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


