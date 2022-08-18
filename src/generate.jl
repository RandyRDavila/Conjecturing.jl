# function make_base_upper_linear_conjecture(
#     data::DataFrame,
#     target::String,
#     other::String,
#     object_type
# )
#     (X, y, objects) = get_base_data_arrays(data, target, other)

#     model = JuMP.Model(GLPK.Optimizer)
#     @variable(model, m)
#     @variable(model, b)
#     @objective(model, Min, sum(X*m) + b)

#     @constraint(model, m >= .25)
#     @constraint(model, m <= 2)
#     @constraint(model, b <= 1)
#     for (x, y) in zip(X, y)
#         @constraint(model, x*m + b >= y)
#         @constraint(model, x*m - b >= 1)  
#     end

#     JuMP.optimize!(model)
    
#     props = [object_type]
#     conj = LinearConjecture(target, other, "≤", 0.0, 0.0, props, 0, objects, object_type)
#     conj.m = rationalize(JuMP.value(m), tol = .095)
#     conj.b = rationalize(JuMP.value(b), tol = .095)
#     for (x, y) in zip(X, y)
#         if conj.m*x + conj.b == y
#             conj.touch_number += 1
#         end
#     end
#     return conj
# end

function find_slope_intercept(
    X::Vector{T},
    y::Vector{T},
    ::Type{UpperBound};
    optimizer=GLPK.Optimizer
) where T <: Number
    model = JuMP.Model(optimizer)
    @variable(model, m)
    @variable(model, b)
    @objective(model, Min, sum(m*X .+ b))
    @constraint(model, m*X .+ b .>= y)
    JuMP.optimize!(model)
    return value(m), value(b)
end


function find_slope_intercept(
    X::Vector{T},
    y::Vector{T},
    ::Type{LowerBound};
    optimizer=GLPK.Optimizer
) where T <: Number
    model = JuMP.Model(optimizer)
    @variable(model, m)
    @variable(model, b)
    @objective(model, Max, sum(m*X .+ b))
    @constraint(model, m*X .+ b .<= y)
    JuMP.optimize!(model)
    return value(m), value(b)
end