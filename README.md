# **Unless you are using the classic Mohor debug interface, you should now use the upstream version of OpenOCD**


OpenOCD
=======

openOCD including OpenRISC support with Mohor debug interface and
Nathan Yawn adv_dbg_if debug interface.

A JTAG driver acting as a client for a VPI JTAG server interface is also
included.

    +---------------     +----------------+      +----------------+      +------------------+      +----------+ 
    +              +     +                +      +                +      +                  +      +          + 
    + OpenOCD core + --> + JAG VIP driver + <==> + JAG VIP server + <--> + JTAG VPI verilog + <--> + JTAG TAP + 
    +              +     +                +      +                +      +                  +      +          + 
    +---------------     +----------------+      +----------------+      +------------------+      +----------+
                             jtag_vpi.c              jtag_vpi.c               jtag_vpi.v             any tap...
    --------------------------------------- TCP  ------------------  VPI --------------------------------------
    ---------------------------------------      --------------------------------------------------------------
                  OpenOCD                                                VPI + Verilog RTL

If you want to use the VPI JTAG driver, you need to configure OpenOCD like this:

    ./configure --enable-jtag_vpi --enable-adv_debug_sys --enable-maintainer-mode

Then you can start OpenOCD:

    ./src/openocd -f jtag_vpi.tcl

The JTAG VPI server (on the simulation side) has to be started before OpenOCD.

