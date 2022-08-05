require 'yaml'
require_relative 'sentence'

sf = SentenceFile.new('sentences.yml')

sm = sf.sample
puts sm.particles_highlighted
puts sm.sans_particles
p sm.particles
