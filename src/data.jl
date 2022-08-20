"""
Get statistics from CSV file
"""
function get_statistics(file::CSV.File)
    stats = Vector{Statistic}()
    for (col_name, col_type) in zip(file.names, file.types)
        if col_type != Bool
            push!(stats, Statistic(String(col_name), file[col_name]))
        end
    end
    return stats
end


"""
Get properties from CSV file
"""
function get_properties(file::CSV.File)
    props = Vector{Property}()
    for (col_name, col_type) in zip(file.names, file.types)
        if col_type == Bool
            push!(props, Property(String(col_name), file[col_name]))
        end
    end
    return props
end
