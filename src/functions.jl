
export write_to_me
export surprise_me


using DataFrames
using DataFramesMeta
using CSV
using JuMP
using GLPK

#include("conjecture_type.jl")


"""
        get_properties(data::DataFrame)

Find the non-boolean column names in your DataFrame

### Input

- `data` -- a Julia DataFrame; this dataframe should contain invariants along 
            the columns and one column should be named name.


### Output

Array of Arrays containing the non-boolean column names in `data`.

"""
function get_properties(data::DataFrame)
    return [[column] for column in names(data) if typeof(data[:, column]) == Vector{Bool}]
end
   


"""
        get_invariants(data::DataFrame)

Find the invariant column names in your DataFrame

### Input

- `data` -- a Julia DataFrame; this dataframe should contain invariants along 
            the columns and one column should be named name.


### Output

Array of Strings containing the invariant column names in `data`.

"""
function get_invariants(data::DataFrame)
    # Call get_properties function here
    properties = [column for column in names(data) 
                if typeof(data[:, column]) == Vector{Bool}]
    push!(properties, "name")
    return [column for column in names(data) if column ∉ properties]
end


"""
        get_data_arrays(data::DataFrame, target::String)

Retrieve the values from the DataFrame under the target column. 

### Input

- `data` -- a Julia DataFrame; this dataframe should contain invariants along 
            the columns and one column should be named name.

- `target` -- a Julia String; this string is the name of the invariant selected. 


### Output

Array of Strings containing the invariant column names in `data`.

"""
function get_base_data_arrays(data::DataFrame, target::String, other::String)
    X = data[:, other]
    y = data[:, target]
    objects = data[:, :name]
    return X, y, objects
end


function get_data_arrays(data::DataFrame, target::String, other::String, properties)
    if length(properties) == 1
        prop = properties[1]
        data = @subset(data, cols(prop) .== true)
    else
        prop1 = properties[1]
        prop2 = properties[2]
        data = @subset(data, cols(prop1) .== true, cols(prop2) .== true)
    end

    X = data[:, other]
    y = data[:, target]
    objects = data[:, :name]
    return X, y, objects
end


function make_base_upper_linear_conjecture(data::DataFrame, target::String, other::String, object_type)
    (X, y, objects) = get_base_data_arrays(data, target, other)

    model = JuMP.Model(GLPK.Optimizer)
    @variable(model, m)
    @variable(model, b)
    @objective(model, Min, sum(X*m) + b)

    @constraint(model, m >= .25)
    @constraint(model, m <= 2)
    @constraint(model, b <= 1)
    for (x, y) in zip(X, y)
        @constraint(model, x*m + b >= y)
        @constraint(model, x*m - b >= 1)  
    end

    JuMP.optimize!(model)
    
    props = [object_type]
    conj = LinearConjecture(target,  other, "≤", 0.0, 0.0, props, 0, objects, object_type)
    conj.m = rationalize(JuMP.value(m), tol = .095)
    conj.b = rationalize(JuMP.value(b), tol = .095)
    for (x, y) in zip(X, y)
        if conj.m*x + conj.b == y
            conj.touch_number += 1
        end
    end
    return conj
end



function make_upper_linear_conjecture(data::DataFrame, 
                                      target::String, 
                                      other::String, 
                                      props::Vector{String}, 
                                      object_type::String)
    (X, y, objects) = get_data_arrays(data, target, other, props)

    model = JuMP.Model(GLPK.Optimizer)
    @variable(model, m)
    @variable(model, b)
    @objective(model, Min, sum(X*m) + b)

    @constraint(model, m >= .25)
    @constraint(model, m <= 2)
    @constraint(model, b <= 1)
    for (x, y) in zip(X, y)
        @constraint(model, x*m + b >= y)
        @constraint(model, x*m - b >= 1)  
    end

    JuMP.optimize!(model)
    
    props = [prop for prop in props]
    conj = LinearConjecture(target,  other, "≤", 0.0, 0.0, props, 0, objects, object_type)
    conj.m = rationalize(JuMP.value(m), tol = .095)
    conj.b = rationalize(JuMP.value(b), tol = .095)
    for (x, y) in zip(X, y)
        if conj.m*x + conj.b == y
            conj.touch_number += 1
        end
    end
    return conj
end


function make_base_lower_linear_conjecture(data::DataFrame, 
                                           target::String, 
                                           other::String, 
                                           object_type::String)
    (X, y, objects) = get_base_data_arrays(data, target, other)

    model = JuMP.Model(GLPK.Optimizer)
    @variable(model, m)
    @variable(model, b)
    @objective(model, Max, sum(X*m) + b)

    @constraint(model, m >= .25)
    @constraint(model, m <= 4.0)
    @constraint(model, b <= 4.0)
    @constraint(model, b >= 0.0)
    for (x, y) in zip(X, y)
        @constraint(model, x*m + b <= y)
        @constraint(model, x*m - b >= 1)  
    end

    JuMP.optimize!(model)
    props = [object_type]
    conj = LinearConjecture(target,  other, "≥", 0.0, 0.0, props, 0, objects, object_type)
    conj.m = rationalize(JuMP.value(m), tol = .085)
    conj.b = rationalize(JuMP.value(b), tol = .085)
    for (x, y) in zip(X, y)
        if conj.m*x + conj.b == y
            conj.touch_number += 1
        end
    end

    return conj
end




function make_lower_linear_conjecture(data::DataFrame, 
                                      target::String, 
                                      other::String, 
                                      props::Vector{String}, 
                                      object_type::String)
    (X, y, objects) = get_data_arrays(data, target, other, props)

    model = JuMP.Model(GLPK.Optimizer)
    @variable(model, m)
    @variable(model, b)
    @objective(model, Max, sum(X*m) + b)

    @constraint(model, m >= .25)
    @constraint(model, m <= 4.0)
    @constraint(model, b <= 4.0)
    @constraint(model, b >= 0.0)
    for (x, y) in zip(X, y)
        @constraint(model, x*m + b <= y)
        @constraint(model, x*m - b >= 1)  
    end

    JuMP.optimize!(model)
    props = [Symbol(prop) for prop in props]
    conj = LinearConjecture(target,  other, "≥", 0.0, 0.0, props, 0, objects, object_type)
    conj.m = rationalize(JuMP.value(m), tol = .085)
    conj.b = rationalize(JuMP.value(b), tol = .085)
    for (x, y) in zip(X, y)
        if conj.m*x + conj.b == y
            conj.touch_number += 1
        end
    end

    return conj
end


function make_conjectures(data::DataFrame, 
                         targets::Vector{String}, 
                         invariants::Vector{String}, 
                         properties::Vector{Vector{String}}, 
                         object_type::String)
    conjs = []
    for target in targets
        invar = [x for x in invariants if x != target]
        for x in invar
            upper = make_base_upper_linear_conjecture(data, target, x, object_type)
            lower = make_base_lower_linear_conjecture(data, target, x, object_type)
            if upper.touch_number > 0
                push!(conjs, upper)
            end
            if lower.touch_number > 0
                push!(conjs, lower)
            end
            for p in properties
                upper = make_upper_linear_conjecture(data, target, x, p, object_type)
                lower = make_lower_linear_conjecture(data, target, x, p, object_type)
                if upper.touch_number > 0
                    push!(conjs, upper)
                end
                if lower.touch_number > 0
                    push!(conjs, lower)
                end
            end
        end
    end
    sort!(conjs, by = conj -> conj.touch_number, rev = true)
    return conjs
end



function filter(conjs)
    bad_indices = []
    for conj1 in conjs
        for (i, conj) in enumerate(conjs)
            if get_expression(conj) == get_expression(conj1) && Set(conj.objects) ⊊ Set(conj1.objects)
                push!(bad_indices, i)
            end
        end
    end
    bad_indices = Set(bad_indices)
    bad_indices = [x for x in bad_indices]
    sort!(bad_indices)
    deleteat!(conjs, bad_indices)
    return conjs
end

function write_to_me(file_name::String, 
                    target::String; 
                    conj_lims = 1:50, 
                    use_test_data = false,
                    object_type = "connected graph")
    # Read invariant data from csv 
    data = CSV.File(file_name)

    # Convert data to a DataFrame type 
    data = DataFrames.DataFrame(data)

    # Collect property names from the DataFrame
    properties = get_properties(data)

    # Collect invariant names from the DataFrame
    invariants = get_invariants(data)

    if use_test_data == true
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
    end

    conjs = make_conjectures(data, [target], invariants, properties, object_type)
    conjs = filter(conjs)

    println()
    println("Do these surprise you? 💙💙 \n")
    for i in conj_lims
        println("Conjecture $(i). ",  conj_string(conjs[i]))
        println("touch number = $(conjs[i].touch_number) \n")
    end
    return conjs[conj_lims]

end

function surprise_me(file_name; use_test_data = false, conj_lims = 1:50 )
    # Read invariant data from csv 
    data = CSV.File(file_name)

    # Convert data to a DataFrame type 
    data = DataFrames.DataFrame(data)

    # Collect property names from the DataFrame
    properties = get_properties(data)

    # Collect invariant names from the DataFrame
    invariants = get_invariants(data)

    if use_test_data == true
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
    end

    # Find random invariant to conjecture on
    i = rand(1:length(invariants))
    target = invariants[i]
    conjs = make_conjectures(data, [target], invariants, properties, "connected_graph")
    conjs = filter(conjs)

    println()
    println("What do you think about these? 💙💙 \n")
    for i in conj_lims
        println("Conjecture $(i). ",  conj_string(conjs[i]))
        println("touch number = $(conjs[i].touch_number) \n")
    end

    return conjs[conj_lims]
end