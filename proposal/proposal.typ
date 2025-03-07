= Proposal

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


