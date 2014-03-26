function jpleph(mjd2k_TDB::Float64,targetId::ASCIIString,observerId::ASCIIString)
    const refId="J2000"
    const aberrId="NONE"
    const lt::Float64=0

    state=Array(Float64,6)
    et=(mjd2k_TDB-0.5)*86400

    ccall((:spkezr_c,"/usr/local/lib/cspice/lib/cspice.dylib"),Void,(Ptr{Uint8},Float64,Ptr{Uint8},Ptr{Uint8},Ptr{Uint8},Ptr{Float64},Ptr{Float64},Uint),targetId,et,refId,aberrId,observerId,state,&lt,length(state))
    state
end

function jpleph(mjd2k_TDB::Array{Float64,1},targetId::ASCIIString,observerId::ASCIIString)
    states=Array(Float64,6,length(mjd2k_TDB))
    state=Array(Float64,6)  
  
    for j=1:length(mjd2k_TDB)
        states[:,j]=jpleph(mjd2k_TDB[j],targetId,observerId) 
    end
    return(states)
end
