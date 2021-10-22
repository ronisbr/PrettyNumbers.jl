module PrettyNumbers

using Printf

################################################################################
#                                   Includes
################################################################################

include("./constants.jl")
include("./misc.jl")
include("./print.jl")

include("./backends/text/print.jl")
include("./backends/text/render.jl")

end # module
