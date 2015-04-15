require "awesome_print"
require "./types_of_cases.rb"

@n = gets.chomp.to_i

print "Minimum Exceution time"
@min_exection_time = gets.chomp.to_i

print "Maximum Exceution time"
@max_exection_time = gets.chomp.to_i

# ap n

include TypesOfCases

produce_random_cases(1)
produce_alternate_cases(1)
produce_loose_alternate(1)
all_small
all_big
increasing
decreasing