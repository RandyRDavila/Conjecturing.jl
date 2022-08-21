function filter(conjectures::Vector{Conjecture})
    bad_indices = []
    for c1 in conjectures
        for (i, c) in enumerate(conjectures)
            if c.expression == c1.expression && Set(c.objects) ⊊ Set(c1.objects)
                push!(bad_indices, i)
            end
        end
    end
    bad_indices = Set(bad_indices)
    bad_indices = [x for x in bad_indices]
    sort!(bad_indices)
    deleteat!(conjectures, bad_indices)
    return conjectures
end