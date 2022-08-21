function find_slope_intercept(
    X::Vector{<:Number},
    y::Vector{<:Number},
    ::Type{UpperBound};
    optimizer=GLPK.Optimizer
)
    model = JuMP.Model(optimizer)
    @variable(model, m)
    @variable(model, b)
    @objective(model, Min, sum(m * X .+ b))
    @constraint(model, m * X .+ b .>= y)
    JuMP.optimize!(model)
    return value(m), value(b)
end


function find_slope_intercept(
    X::Vector{<:Number},
    y::Vector{<:Number},
    ::Type{LowerBound};
    optimizer=GLPK.Optimizer
)
    model = JuMP.Model(optimizer)
    @variable(model, m)
    @variable(model, b)
    @objective(model, Max, sum(m * X .+ b))
    @constraint(model, m * X .+ b .<= y)
    JuMP.optimize!(model)
    return value(m), value(b)
end


function conjecture(
    T::Type{<:AbstractConjecture},
    objects::Vector,
    object_type::String,
    target::Statistic,
    other::Statistic,
    hypotheses::Vector{String}=Vector{String}();
    rationalization_tol=0.095
)
    m, b = find_slope_intercept(other.values, target.values, T)
    mr = rationalize(m; tol=rationalization_tol)
    br = rationalize(b; tol=rationalization_tol)
    expression = "$mr*$(other.name) + $br"
    touch_number = sum(mr * other.values .+ br .== target.values)
    return Conjecture{T}(target, expression, hypotheses, touch_number, objects, object_type)
end


function conjectures(
    objects::Vector{String},
    object_type::String,
    targets::Vector{Statistic},
    statistics::Vector{Statistic},
    properties::Vector{Property}=Property[],
)
    conjs = Vector{Conjecture}()

    # filter objects to include only those with the correct properties
    if isempty(properties)
        objs_to_keep = [true for _ in objects]
    else
        objs_to_keep = [all(x) for x in zip([p.values for p in properties]...)]
    end
    indices = findall(objs_to_keep)
    filtered_objs = objects[indices]
    filtered_tgts = [Statistic(t.name, t.values[indices]) for t in targets]
    filtered_stats = [Statistic(s.name, s.values[indices]) for s in statistics]
    hyp = [p.name for p in properties]

    # generate conjecture for each combination of target and statistic
    for target in filtered_tgts
        for stat in (s for s in filtered_stats if s != target)
            for T in (UpperBound, LowerBound)
                c = conjecture(T, filtered_objs, object_type, target, stat, hyp)
                if c.touch_number > 0
                    push!(conjs, c)
                end
            end
        end
    end
    return conjs
end


function conjectures_on(
    data::Dataset;
    targets::Vector{String}=String[],
    min_num_hypotheses::Integer=0,
    max_num_hypotheses::Integer=2
)
    if isempty(targets)
        target_stats = Vector{Statistic}(data.statistics)
    else
        target_stats = Vector{Statistic}([s for s in data.statistics if s.name in targets])
    end

    conjs = Vector{Conjecture}()
    for props in powerset(data.properties, min_num_hypotheses, max_num_hypotheses)
        new_conjs = conjectures(data.objects, data.name, target_stats, data.statistics, props)
        conjs = vcat(conjs, new_conjs)
    end

    conjs = filter(conjs)
    sort!(conjs, by=c -> c.touch_number, rev=true)
    return conjs
end