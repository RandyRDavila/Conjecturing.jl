module Conjecturing

    using GLPK
    using JuMP

    include("statistic.jl")
    include("conjecture.jl")
    include("generate.jl")

    export Statistic
    export AbstractConjecture, UpperBound, LowerBound
    export Conjecture

end
