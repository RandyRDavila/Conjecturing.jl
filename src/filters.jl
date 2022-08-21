# function filter(conjectures::Vector{Conjecture})
#     indices_to_keep = []
#     for c1 in conjectures
#         for (i, c) in enumerate(conjectures)
#             if c.expression != c1.expression || Set(c.objects) ⊇ Set(c1.objects)
#                 push!(indices_to_keep, i)
#             end
#         end
#     end
#     indices_to_keep = sort!([x for x in Set(indices_to_keep)])
#     return conjectures[indices_to_keep]
# end

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