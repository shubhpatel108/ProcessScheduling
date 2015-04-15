require "awesome_print"
require "./types_of_cases.rb"
require "gruff"

@n = gets.chomp.to_i

print "Minimum Exceution time"
@min_exection_time = gets.chomp.to_i

print "Maximum Exceution time"
@max_exection_time = gets.chomp.to_i

# ap n

include TypesOfCases

g = Gruff::Line.new

g.title = 'Processes with Random execution time'
batches = produce_random_cases(2)
# produce_alternate_cases(1)
# produce_loose_alternate(1)
# all_small
# all_big
# increasing
# decreasing


pids = {}
(1..@n).each_with_index do |pid, i|
	pids[i] = pid.to_s
end
g.labels = pids

batches.each_with_index do |batch, i|
	g.data "Batch no #{i+1}", batch.map{|p| p.last}
end

g.x_axis_label = 'PIDs'
g.y_axis_label = 'Execution time in secs'

g.write('cases.png')
value = %x( eog cases.png )