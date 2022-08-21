"""
Get statistics from CSV file
"""
function get_statistics(file::CSV.File)
    stats = Vector{Statistic}()
    for (col_name, col_type) in zip(file.names, file.types)
        if col_type <: Number && col_type != Bool
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


struct Dataset
    name::String
    objects::Vector
    statistics::Vector{Statistic}
    properties::Vector{Property}
end

function Base.show(io::IO, d::Dataset)
    s = "Dataset \"$(d.name)\" ("
    s *= "$(length(d.objects)) objects, "
    s *= "$(length(d.statistics)) statistics, "
    s *= "$(length(d.properties)) properties)"
    print(io, s)
end

function dataset_from_csv(name::String, path::String, types::Dict{Symbol,DataType})
    data = CSV.File(path, types=types)
    objects = data[:name]
    statistics = get_statistics(data)
    properties = get_properties(data)
    return Dataset(name, objects, statistics, properties)
end
