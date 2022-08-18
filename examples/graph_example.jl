using Conjecturing
using DataFrames
using CSV

include("graph_config.jl")



conjs = conjecture(
    "examples/data/graph_data.csv",
    "matching_number",
    "connected graph",
    types = graph_types,
    print_only = true,
    conj_lims = 1:50
);



