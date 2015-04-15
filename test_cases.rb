require "awesome_print"
@n = gets.chomp.to_i

print "Minimum Exceution time"
@min_exection_time = gets.chomp.to_i

print "Maximum Exceution time"
@max_exection_time = gets.chomp.to_i

# ap n



def produce_random_cases(count)
	(count).times do
		batch = []

		(1..@n).each do |i|
			exceution_time = rand(@min_exection_time-1..@max_exection_time)
			process = [i, 0, exceution_time]
			batch << process
		end

		puts batch.to_s

	end
end

def produce_alternate_cases(count)
	(count).times do
		batch = []

		(1..@n).each do |i|
			if i%2==0
				exceution_time = @max_exection_time
			else
				exceution_time = @min_exection_time
			end
			process = [i, 0, exceution_time]
			batch << process
		end

		puts batch.to_s
	end
end

def produce_loose_alternate(count)
	(count).times do
		batch = []

		lower = @min_exection_time + (@max_exection_time - @min_exection_time)/3
		upper = @max_exection_time - (@max_exection_time - @min_exection_time)/3

		(1..@n).each do |i|
			if i%2==0
				exceution_time = rand(upper..@max_exection_time)
			else
				exceution_time = rand(@min_exection_time-1..lower)
			end
			process = [i, 0, exceution_time]
			batch << process
		end

		puts batch.to_s
	end
end

def all_small(count=1)
	count.times do
		batch = []
		(1..@n).each do |i|
			exceution_time = @min_exection_time
			process = [i, 0, exceution_time]
			batch << process
		end

		puts batch.to_s
	end
end

def all_big(count=1)
	count.times do
		batch = []
		(1..@n).each do |i|
			exceution_time = @max_exection_time
			process = [i, 0, exceution_time]
			batch << process
		end

		puts batch.to_s
	end
end

def increasing
	multiplier = (@max_exection_time.to_f - @min_exection_time.to_f)/@n
	batch = []

	(1..@n).each do |i|
		exceution_time = (@min_exection_time + multiplier*i).to_i
		process = [i, 0, exceution_time]
		batch << process
	end

	puts batch.to_s
end

produce_random_cases(1)
produce_alternate_cases(1)
produce_loose_alternate(1)
all_small
all_big
increasing