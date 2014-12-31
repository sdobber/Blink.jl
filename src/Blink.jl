module Blink

using Lazy

include("process.jl")
include("jsexprs.jl")
include("jscall.jl")
include("window.jl")
include("utils.jl")

end # module

include("display/graphics.jl")
using Graphics