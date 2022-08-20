module Conjecturing

    using CSV
    using GLPK
    using JuMP

    include("statistic.jl")
    include("property.jl")
    include("data.jl")
    include("conjecture.jl")
    include("generate.jl")

    export Statistic
    export Property
    export AbstractConjecture
    export UpperBound, LowerBound
    export Conjecture

end
