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
g1 = Gruff::Line.new
g2 = Gruff::Line.new
g3 = Gruff::Line.new


case choice
when 1
	g1.title = 'Random execution time, Response Time'
	g2.title = 'Random execution time, Turn Around Time'
	batches = produce_random_cases(20)

when 2
	g1.title = 'Alternate execution time, Response Time'
	g2.title = 'Alternate execution time, Turn Around Time'
	batches = produce_alternate_cases(20)

when 3
	g1.title = 'loose alternate execution time, Response Time'
	g2.title = 'loose alternate execution time, Turn Around Time'
	batches = produce_loose_alternate(20)

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
	batches = increasing(20)

when 7
	g1.title = 'Decreasing execution time, Response Time'
	g2.title = 'Decreasing execution time, Turn Around Time'
	batches = decreasing(20)

when 8
	g1.title = 'Random alternative time, Response Time'
	g2.title = 'Random alternative time, Turn Around Time'
	batches = random_alternate(20)

when 9
	g1.title = 'Bump in middle, Response Time'
	g2.title = 'Bump in middle, Turn Around Time'
	batches = bump(20)

when 10
	g1.title = 'All same, Response Time'
	g2.title = 'All same, Turn Around Time'
	batches = all_same(20)
end

srt_resp = []
sjf_resp = []
fcfs_resp = []
rr_resp = []
rating = []

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
	rr_resp << round_robin(temp, 10.0, 0.01)
	c = []
	c = [srt_resp[batch_no-1][1], sjf_resp[batch_no-1][1], fcfs_resp[batch_no-1][1], rr_resp[batch_no-1][1]].minmax
	a = c[0]
	b = c[1]
	unit = (b-a)/4.0
	rsrt = 0.0
	rsjf = 0.0
	rfcfs = 0.0
	rrr = 0.0
	if srt_resp[batch_no-1][1] <= a + unit
		rsrt += 10.0
	elsif srt_resp[batch_no-1][1] <= a + (2*unit)
		rsrt += 7.5
	elsif srt_resp[batch_no-1][1] <= a + (3*unit)
		rsrt += 5.0
	elsif srt_resp[batch_no-1][1] <= b
		rsrt += 2.5
	end

	if sjf_resp[batch_no-1][1] <= a + unit
		rsjf += 10.0
	elsif sjf_resp[batch_no-1][1] <= a + (2*unit)
		rsjf += 7.5
	elsif sjf_resp[batch_no-1][1] <= a + (3*unit)
		rsjf += 5.0
	elsif sjf_resp[batch_no-1][1] <= b
		rsjf += 2.5
	end	
		
	if fcfs_resp[batch_no-1][1] <= a + unit
		rfcfs += 10.0
	elsif fcfs_resp[batch_no-1][1] <= a + (2*unit)
		rfcfs += 7.5
	elsif fcfs_resp[batch_no-1][1] <= a + (3*unit)
		rfcfs += 5.0
	elsif fcfs_resp[batch_no-1][1] <= b
		rfcfs += 2.5
	end

	if rr_resp[batch_no-1][1] <= a + unit
		rrr += 10.0
	elsif rr_resp[batch_no-1][1] <= a + (2*unit)
		rrr += 7.5
	elsif rr_resp[batch_no-1][1] <= a + (3*unit)
		rrr += 5.0
	elsif rr_resp[batch_no-1][1] <= b
		rrr += 2.5
	end

	c = [srt_resp[batch_no-1][2], sjf_resp[batch_no-1][2], fcfs_resp[batch_no-1][2], rr_resp[batch_no-1][2]].minmax
	a = c[0]
	b = c[1]
	unit = (b-a)/4.0
	if srt_resp[batch_no-1][2] <= a + unit
		rsrt += 10.0
	elsif srt_resp[batch_no-1][2] <= a + (2*unit)
		rsrt += 7.5
	elsif srt_resp[batch_no-1][2] <= a + (3*unit)
		rsrt += 5.0
	elsif srt_resp[batch_no-1][2] <= b
		rsrt += 2.5
	end

	if sjf_resp[batch_no-1][2] <= a + unit
		rsjf += 10.0
	elsif sjf_resp[batch_no-1][2] <= a + (2*unit)
		rsjf += 7.5
	elsif sjf_resp[batch_no-1][2] <= a + (3*unit)
		rsjf += 5.0
	elsif sjf_resp[batch_no-1][2] <= b
		rsjf += 2.5
	end	
		
	if fcfs_resp[batch_no-1][2] <= a + unit
		rfcfs += 10.0
	elsif fcfs_resp[batch_no-1][2] <= a + (2*unit)
		rfcfs += 7.5
	elsif fcfs_resp[batch_no-1][2] <= a + (3*unit)
		rfcfs += 5.0
	elsif fcfs_resp[batch_no-1][2] <= b
		rfcfs += 2.5
	end

	if rr_resp[batch_no-1][2] <= a + unit
		rrr += 10.0
	elsif rr_resp[batch_no-1][2] <= a + (2*unit)
		rrr += 7.5
	elsif rr_resp[batch_no-1][2] <= a + (3*unit)
		rrr += 5.0
	elsif rr_resp[batch_no-1][2] <= b
		rrr += 2.5
	end
	rating << [rsrt, rsjf, rfcfs, rrr]
	print rating[batch_no-1]
	print "\n"
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

g.write('execution.png')
fork do
	value = %x( eog execution.png &)
end



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
x = 1
y = 1

g3.labels = batch_nos
g3.data "Shortest remaining time first", rating.map { |r| r[0]}
g3.data "Shortest Job first", rating.map { |r| r[1]}
g3.data "First come first serve", rating.map { |r| r[2]}
g3.data "Round Robin", rating.map { |r| r[3]}

g3.x_axis_label = 'Batch no'
g3.y_axis_label = 'Time rating'

g3.write('cases2.png')
fork do
	value = %x( eog cases2.png )
end
