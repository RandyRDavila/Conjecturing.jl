using Conjecturing
using DataFrames
using CSV

# This dictionary is specific to sequence data
sequence_types = Dict(
    :name => String,
    :min => Int,
    :max => Int,
    :mean => Float64,
    :first => Int,
    :last => Int,
    :next_term => Int,
    :geometric => Bool,
    :arithmetic => Bool,
    :avg_difference => Float64,
    :last_difference_plus_last_term => Int
)


conjs = conjecture(
    "sequence_data.csv",
    "next_term",
    "integer increasing sequence",
    types = sequence_types,
    print_only = true,
);



