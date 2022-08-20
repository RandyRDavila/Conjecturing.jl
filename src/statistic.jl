mutable struct Statistic{T <: Number}
    name::String
    values::Vector{T}
end

function Base.:(==)(x::Statistic, y::Statistic)
    return (typeof(x) == typeof(y)
        && x.name == y.name
        && x.values == y.values)
end

function Base.show(io::IO, s::Statistic)
    print(io, "Statistic{$(eltype(s.values))}(\"$(s.name)\", $(s.values))")
end