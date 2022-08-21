abstract type AbstractConjecture end
abstract type UpperBound <: AbstractConjecture end
abstract type LowerBound <: AbstractConjecture end

mutable struct Conjecture{T<:AbstractConjecture}
    target::Statistic
    expression::String
    hypotheses::Vector{String}
    touch_number::Integer
    objects::Vector{Any}
    object_type::String
end

function _show(io::IO, c::Conjecture, op::String)
    s = "$(c.object_type)"
    if length(c.hypotheses) > 0
        s *= "(" * join(c.hypotheses, ", ") * ")"
    end
    s *= " ⟹  $(c.target.name) $(op) $(c.expression)"
    print(io, s)
end

Base.show(io::IO, conj::Conjecture{UpperBound}) = _show(io, conj, "<=")
Base.show(io::IO, conj::Conjecture{LowerBound}) = _show(io, conj, ">=")