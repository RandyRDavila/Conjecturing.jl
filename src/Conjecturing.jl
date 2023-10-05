module Conjecturing

using HTTP
using CSV
using DataFrames
using FIGlet



include("functions.jl")
include("conjecture_type.jl")

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

new_graph_types = Dict(
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

function make_graph_conjectures(
    target::String;
    conj_lims = 1:60,
    print_only = true
)
    data = data = CSV.read(
        HTTP.get(
            "https://raw.githubusercontent.com/RandyRDavila/Conjecturing.jl/main/examples/data/new_graph_data.csv").body,
            DataFrame
        )

    # Collect property names from the DataFrame
    properties = get_properties(data)

    # Collect invariant names from the DataFrame
    invariants = get_invariants(data)

    # Specific properties of interest to graph theory
    custum_properties = [
        ["regular", "not_K_n"],
        ["cubic", "not_K_n"],
        ["sub_cubic", "not_K_n"],
        ["cubic", "claw_free"],
        ["cubic", "triangle_free"],
        ["regular", "claw_free"],
        ]

    # Add optional custom properties
    for prop in custum_properties
        push!(properties, prop)
    end

    conjs = make_conjectures(
        data,
        [target],
        invariants,
        properties,
        "connected graph"
    )
    conjs = Conjecturing.filter(conjs)


    if print_only
        FIGlet.render("Conjecturing.jl", "slant")
        println("-----------------------------------------------")
        println("Version  0.1.0")
        println("Copyright 2022 Randy Davila and David Amos")
        println("-----------------------------------------------")
        println()
        if conj_lims !== nothing
            for i in conj_lims
                println("Conjecture $(i). ",  conj_string(conjs[i]))
                println("touch number = $(conjs[i].touch_number) \n")
            end
        else
            for (i, c) in enumerate(conjs)
                println("Conjecture $(i). ",  conj_string(c))
                println("touch number = $(c.touch_number) \n")
            end
            return nothing
        end
    end
    return conjs
end


export conjecture
export random_conjecture
export LinearConjecture
export conj_string
export conj_println
export inequality
export get_expression
export get_properties
export get_invariants
export make_conjectures
export make_graph_conjectures

end
