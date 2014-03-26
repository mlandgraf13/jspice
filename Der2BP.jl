#---------------------------------------------------
# der - vector field of the dynamics of the two-body
#       problem (2bp)
# INPUT
#  t - epoch in ET (see spice docs for definition of ET)
#  x -  state vector in km,km/s
# OUTPUT
#  d - Array{Float64,6} vector field at the state
#      vector in km/s,km/s^2
# written by Markus Landgraf. Last modified 13Oct13.
#---------------------------------------------------
module Der2BP
export der

using myconst

function der(t,x)
    mu=planets["earth"]["mu"]
    d=[x[4:6];-mu/norm(x[1:3])^3*x[1:3]]
end

end
