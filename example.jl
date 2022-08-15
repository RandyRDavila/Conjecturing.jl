using Conjecturing
using DataFrames
using CSV

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

number_types = Dict(
    :name => String,
    :prime => Bool,
    :even => Bool,
    :odd => Bool,
    :num_prime_factors => Int,
    :n_squared => Int,
    :sum_to_n => Int,
    :num_primes_less_than_n => Int,
    :not_two => Bool,
    :sqrt => Float64,
)




random_conjecture(
    "numbers.csv";
    object_type = "positive integer",
    types=number_types,
    #use_test_data = true
);
