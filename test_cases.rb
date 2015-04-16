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

g1 = Gruff::Line.new
g2 = Gruff::Line.new


case choice
when 1
	g1.title = 'Random execution time, Response Time'
	g2.title = 'Random execution time, Turn Around Time'
	batches = produce_random_cases(20)

when 2
	g1.title = 'Alternate execution time, Response Time'
	g2.title = 'Alternate execution time, Turn Around Time'
	batches = produce_alternate_cases

when 3
	g1.title = 'loose alternate execution time, Response Time'
	g2.title = 'loose alternate execution time, Turn Around Time'
	batches = produce_loose_alternate(2)

when 4
	g1.title = 'All smallest execution time, Response Time'
	g2.title = 'All smallest execution time, Turn Around Time'
	batches = all_small

when 5
	g1.title = 'All largest execution time, Response Time'
	g2.title = 'All largest execution time, Turn Around Time'
	batches = all_big

when 6
	g1.title = 'Increasing execution time, Response Time'
	g2.title = 'Increasing execution time, Turn Around Time'
	batches = increasing

when 7
	g1.title = 'Decreasing execution time, Response Time'
	g2.title = 'Decreasing execution time, Turn Around Time'
	batches = decreasing

when 8
	g1.title = 'Random alternative time, Response Time'
	g2.title = 'Random alternative time, Turn Around Time'
	batches = random_alternate(20)
end

srt_resp = []
sjf_resp = []
fcfs_resp = []
rr_resp = []

batch_no = 1
batches.each do |b|
	print "Batch: "
	print batch_no
	print "\n"
	temp = Marshal.load(Marshal.dump(b))
	srt_resp << shortest_remaining_time_first(temp)
	temp = Marshal.load(Marshal.dump(b))
	sjf_resp << shortest_job_first(temp)
	temp = Marshal.load(Marshal.dump(b))
	fcfs_resp << first_come_first_serve(temp)
	temp = Marshal.load(Marshal.dump(b))
	rr_resp << round_robin(temp, 10.0, 1.0)
	batch_no += 1
end

# pids = {}
# (1..@n).each_with_index do |pid, i|
# 	pids[i] = pid.to_s
# end
# g.labels = pids

# batches.each_with_index do |batch, i|
# 	g.data "Batch no #{i+1}", batch.map{|p| p[2]}
# end

# g.x_axis_label = 'PIDs'
# g.y_axis_label = 'Execution time in secs'

batch_nos = {}
batches.each_with_index do |pid, i|
	batch_nos[i + 1] = (i + 1).to_s
end
g1.labels = batch_nos

g1.data "Shortest remaining time first", srt_resp.map{|p| p[1]}
g1.data "Shortest Job first", sjf_resp.map{|p| p[1]}
g1.data "First come first serve", fcfs_resp.map{|p| p[1]}
g1.data "Round Robin", rr_resp.map{|p| p[1]}

g1.x_axis_label = 'Batch no'
g1.y_axis_label = 'Response time'

g1.write('cases.png')
fork do
	value = %x( eog cases.png &)
end

#Graph for turn around time
g2.labels = batch_nos

g2.data "Shortest remaining time first", srt_resp.map{|p| p[2]}
g2.data "Shortest Job first", sjf_resp.map{|p| p[2]}
g2.data "First come first serve", fcfs_resp.map{|p| p[2]}
g2.data "Round Robin", rr_resp.map{|p| p[2]}

g2.x_axis_label = 'Batch no'
g2.y_axis_label = 'Response time'

g2.write('cases1.png')
fork do
	value = %x( eog cases1.png )
end
