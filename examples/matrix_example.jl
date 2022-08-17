using Conjecturing
using DataFrames
using CSV

# This dictionary is specific to the columns in matrix_data.csv
matrix_types = Dict(
    :symmetric => Bool,
    :uppertri => Bool,
    :lowertri => Bool,
    :diagonal => Bool,
    :elementary => Bool,
    :invertible => Bool,
    :numrows => Int,
    :numcols => Int,
    :rank => Int,
    :det => Float64,
    :smallesteig => Float64,
    :largesteig => Float64,
    :name => String,
)

conjs = random_conjecture(
    "examples/matrix_data.csv",
    "square matrix",
    types = matrix_types,
    print_only = true,
);



