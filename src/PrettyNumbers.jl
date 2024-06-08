module PrettyNumbers

using Printf

############################################################################################
#                                          Types                                           #
############################################################################################

const Backend = Union{Val{:text}, Val{:latex}}

############################################################################################
#                                         Includes                                         #
############################################################################################

include("./constants.jl")
include("./misc.jl")
include("./print.jl")

include("./backends/latex/print.jl")
include("./backends/latex/render.jl")

include("./backends/text/print.jl")
include("./backends/text/render.jl")

end # module
