mutable struct Property
    name::String
    values::Vector{Bool}
end

function Base.show(io::IO, p::Property)
    print(io, "Property(\"$(p.name)\", $(p.values))")
end