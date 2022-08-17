using Conjecturing
using DataFrames
using CSV


# This dictionary is specific to the columns in integer_data.csv
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



conjs = random_conjecture(
    "examples/integer_data.csv",
    "positive integer",
    types = number_types,
    print_only = true,
);



