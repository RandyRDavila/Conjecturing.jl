module Conjecturing

    using CSV
    using GLPK
    using JuMP

    include("statistic.jl")
    include("data.jl")
    include("conjecture.jl")
    include("generate.jl")

    export Statistic
    export AbstractConjecture, UpperBound, LowerBound
    export Conjecture

end
