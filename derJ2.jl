#---------------------------------------------------
# der - vector field of the dynamics of the two-body
#       problem (2bp) plus J2 perturbations
# INPUT
#  t - epoch in ET (see spice docs for definition of ET)
#  x -  state vector in km,km/s
# OUTPUT
#  d - Array{Float64,6} vector field at the state
#      vector in km/s,km/s^2
# written by Markus Landgraf. Last modified 13Oct13.
#---------------------------------------------------

module DerJ2
export der

using Astrodynamics

function der(t,x)

    mu=planets["earth"]["mu"]
    J2=planets["earth"]["j2"]
    RE=planets["earth"]["re"]
    r=norm(x[1:3])

# M is the diagonal matrix mapping the terms containing the
#  z-component - see equation (8-48) on page 551 in Vallado
    M=[[1-5*(x[3]/r)^2 0 0];
       [0 1-5*(x[3]/r)^2 0];
       [0 0 3-5*(x[3]/r)^2]]

    d=[x[4:6];-mu/r^3*x[1:3]-3/2*mu*J2*RE^2/r^5*M*x[1:3]]
end
end
