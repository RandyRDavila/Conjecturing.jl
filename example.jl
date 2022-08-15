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

# This dictionary is specific to the columns in graph_data.csv
graph_types = Dict(
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
    :total_forcing_number => Int
)


conjs = random_conjecture(
    "matrix_data.csv",
    "square matrix",
    types = matrix_types,
    print_only = true
);



