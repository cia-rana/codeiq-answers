require "prime"
p (f=->n{Prime.each.take(n)[-1]})[f[gets.to_i]]

=begin
require "prime"
f=->n{Prime.each.take(n)[-1]}[f[gets.to_i]]
p f[f[gets.to_i]]
=end

=begin
require "prime"
p (f=->n{Prime.each.take(n).max})[f[gets.to_i]]
=end