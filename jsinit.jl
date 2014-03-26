function jsinit()
    lt::Float64=0.0
    tlsfn="/usr/local/lib/cspice/data/naif0007.tls"
    de405fn="/usr/local/lib/cspice/data/de405.bsp"

    typeof(tlsfn)
    ccall((:furnsh_c,"/usr/local/lib/cspice/lib/cspice.dylib"),Void,(Ptr{Uint8},),tlsfn)
    ccall((:furnsh_c,"/usr/local/lib/cspice/lib/cspice.dylib"),Void,(Ptr{Uint8},),de405fn)
end
