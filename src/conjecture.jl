abstract type UpperBound end
abstract type LowerBound end

mutable struct Conjecture{T}
    target::String
    other::String
    hypotheses::Vector{String}
    touch_number::Integer
    objects::Vector{Any}
    object_type::String
    object_symbol::String
end

function _show(io::IO, c::Conjecture, op::String)
    s = "If $(c.object_symbol) is a $(c.object_type)"
    if length(c.hypotheses) > 0
        s *= " [" * join(c.hypotheses, ", ") * "]"
    end
    s *= ", then $(c.target)($(c.object_symbol)) $(op) $(c.other)($(c.object_symbol))"
    print(io, s)
end

Base.show(io::IO, conj::Conjecture{UpperBound}) = _show(io, conj, ">=")
Base.show(io::IO, conj::Conjecture{LowerBound}) = _show(io, conj, "<=")