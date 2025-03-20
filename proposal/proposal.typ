#let num(number) = {
  if (number < 999 and number > 0.001) {
    return [$#number$]
  }
  let exponent = calc.floor(calc.log(number, base: 10))
  let mantissa = calc.round(number * calc.pow(10, -exponent), digits: 7)
  // The `round` call is to stop any floating point bullshit
  [$#mantissa times 10^#exponent$]
}

= Proposal

This is our porposal for our amplifier lol

== Specifications

This is all the shit from that one piece of paper they gave us

// Test spec
#let At   = 53.7
#let Cirt = 2.2e-10
#let Rirt = 1e6
#let fm   = 1000

// Interface spec
#let Cr = 2.533e-11
#let Lr = 0.1
#let Rr = 235
#let Cs = 1.091e-10
#let Ls = 0.000314
#let Rs = 8.1
#let kc = 0.000489

// functional spec
#let Rl    = 2000
#let Vi    = 1
#let Vv    = 0.25
#let Zi    = 1e4
#let ffpl  = 5000
#let fmax  = 1.5e4
#let fmin  = 60
#let vfuck = 0.0001

// PSU spec
#let Vn = 15
#let Vp = 15

=== Test specification

#table(
  columns: 4,
  [Symbol],     [Description],                           [Value],       [Units],
  [$A_t$],      [Tx-Rx voltage transfer at test freq. ], [#num(At)   ], [dB],
  [$C_"iRT"$],  [Test Rx input capacitance            ], [#num(Cirt) ], [F],
  [$R_"iRT"$],  [Test Rx input impedance              ], [#num(Rirt) ], [$Omega$],
  [$f_m$],      [Test measurement freq.               ], [#num(fm)   ], [Hz],
)

=== Interface Specification

#table(
  columns: 4,
  [Symbol], [Description],           [Value],           [Units],
  [$C_s$],  [Tx coil capacitance  ], [#num(Cs)], [F],
  [$L_s$],  [Tx coil inductance   ], [#num(Ls)], [H],
  [$R_s$],  [Tx coil resistance   ], [#num(Rs)], [$Omega$],
  [$C_r$],  [Rx coil capacitance  ], [#num(Cr)], [F],
  [$L_r$],  [Rx coil inductance   ], [#num(Lr)], [H],
  [$R_r$],  [Rx coil resistance   ], [#num(Rr)], [$Omega$],
  [$k_c$],  [Coil coupling factor ], [#num(kc)], [$Omega$],
)

=== Functional Specification

#table(
  columns: 4,
  [Symbol], [Description],           [Value],           [Units],
  [$R_l$      ], [Rx load resistance                       ], [#num(Rl)    ], [$Omega$],
  [$V_i$      ], [Tx peak input voltage                    ], [#num(Vi)    ], [V],
  [$V_v$      ], [Rx peak output voltage at max input voltage], [#num(Vv)    ], [V],
  [$Z_i$      ], [Tx input impedance                       ], [#num(Zi)    ], [$Omega$],
  [$f_"fpl"$  ], [Maximum frequency for full-power         ], [#num(ffpl)  ], [Hz],
  [$f_"max"$  ], [Small-signal -3dB low-pass cutoff        ], [#num(fmax)  ], [Hz],
  [$f_"min"$  ], [Small-signal -3dB high-pass cutoff       ], [#num(fmin)  ], [Hz],
  [$v_"fuck"$ ], [Zero-signal RMS output noise over -3dB BW], [#num(vfuck) ], [V],
)

=== Power Suypply Specification

#table(
  columns: 4,
  [Symbol], [Description],           [Value],           [Units],
  [$V_n$      ], [Negative power supply voltage ], [#num(Vn)], [V],
  [$V_p$      ], [Positive power supply voltage ], [#num(Vp)], [V],
)

TODO:

- Noise analysis
- power efficiency
- clipping [?]
- small-signal bandwidth
- frequency response
- DC stability

== Topology

- Filtering in the TX amplifier to be able to make RX simple
		and make easier to avoid noizzze
		(weak signal)
- RX amplifier as noninverting to avoid noisy resistors
		in (weak) signal path
- TX amplifier inverting because then there is no unity gain
		component in the TF so it looks `-\` and not `-\_`

== Gain

- TX amp: input is 1vpp output is maximum 15vpp b/c thats the
		supply voltage. So we want gain of 15.
		But want to leave some heardroom.....
		that is addressed later on.

#let loop_coup=0.000489
#let loop_lrx=0.1
#let loop_ltx=0.000314
#let rx_swing_out=0.25
#let tx_swing_out=15

#let loop_gain = loop_coup * calc.sqrt(loop_ltx / loop_lrx)
#let rx_gain = rx_swing_out / (tx_swing_out * loop_gain)

- RX gain = #rx_gain


