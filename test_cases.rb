require "./types_of_cases.rb"
require "gruff"

print "Number of process in a batch: "
@n = gets.chomp.to_i

print "Minimum Exceution time: "
@min_exection_time = gets.chomp.to_i

print "Maximum Exceution time: "
@max_exection_time = gets.chomp.to_i

print "Enter choice for producing test cases: "
choice = gets.chomp.to_i

include TypesOfCases

g = Gruff::Line.new


case choice
when 1
	# g.title = 'Processes with Random execution time'
	batches = produce_random_cases(2)

when 2
	g.title = 'Processes with Alternate execution time'
	batches = produce_alternate_cases

when 3
	g.title = 'Processes with loose alternate execution time'
	batches = produce_loose_alternate(2)

when 4
	g.title = 'The one with all smallest execution time'
	batches = all_small

when 5
	g.title = 'The one with all largest execution time'
	batches = all_big

when 6
	g.title = 'The one with increasing execution time'
	batches = increasing

when 7
	g.title = 'The one with decreasing execution time'
	batches = decreasing

when 8
	g.title = 'The one with decreasing execution time'
	batches = random_alternate
end

batch_no = 1
batches.each do |b|
	print "Batch: "
	print batch_no
	print "\n"
	temp = b.dup
	shortest_remaining_time_first(temp)
	temp = b.dup
	shortest_job_first(temp)
	temp = b.dup
	first_come_first_serve(temp)
	temp = b.dup
	round_robin(temp, 2.0, 2.0)
	batch_no += 1
end

pids = {}
(1..@n).each_with_index do |pid, i|
	pids[i] = pid.to_s
end
g.labels = pids

batches.each_with_index do |batch, i|
	g.data "Batch no #{i+1}", batch.map{|p| p[2]}
end

g.x_axis_label = 'PIDs'
g.y_axis_label = 'Execution time in secs'

g.write('cases.png')
value = %x( eog cases.png )
