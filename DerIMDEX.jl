#---------------------------------------------------
# der - vector field of the dynamics of the two-body
#       problem (2bp) plus J2 perturbations plus
#       three body perturbations by the Moon and the Sun
# INPUT
#  t - epoch in ET (see spice docs for definition of ET)
#  x -  state vector in km,km/s
# OUTPUT
#  d - Array{Float64,6} vector field at the state
#      vector in km/s,km/s^2
# written by Markus Landgraf. Last modified 13Mar14.
#---------------------------------------------------

module DerIMDEX
export der

using Astrodynamics
using jspice

function der(t,x)

    mu=planets["earth"]["mu"]
    J2=planets["earth"]["j2"]
    RE=planets["earth"]["re"]

# first calculate acceleration terms due to the Earth's gravity field
#
# M is the diagonal matrix mapping the terms containing the
#  z-component - see equation (8-48) on page 551 in Vallado
    r=norm(x[1:3])
    M=[[1-5*(x[3]/r)^2 0              0];
       [0              1-5*(x[3]/r)^2 0];
       [0              0              3-5*(x[3]/r)^2]]

#    aE=-mu/r^3*x[1:3]-3/2*mu*J2*RE^2/r^5*M*x[1:3]
    aE=-mu/r^3*x[1:3]

# now comes the acceleration due to the lunar point mass
    sM=jpleph(t/86400+0.5,"Moon","Earth");
    rM=norm(sM[1:3])
    DM=sM[1:3]-x[1:3]
    distM=norm(DM)
    
    aM=planets["moon"]["mu"]*(DM/distM^3-sM[1:3]/rM^3)

# now comes the acceleration due to the solar point mass
    sS=jpleph(t/86400+0.5,"Sun","Earth");
    rS=norm(sS[1:3])
    DS=sS[1:3]-x[1:3]
    distS=norm(DS)
    
    aS=planets["sun"]["mu"]*(DS/distS^3-sS[1:3]/rS^3)

# the acclerations are summed up
    d=[x[4:6];
       aE+aS+aM]
end
end
