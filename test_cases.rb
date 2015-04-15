require "awesome_print"
n = gets.chomp.to_i

print "Minimum Exceution time"
min_exection_time = gets.chomp.to_i + 1

print "Maximum Exceution time"
max_exection_time = gets.chomp.to_i

# ap n




def produce_random_cases(count)
	(count).times do
		batch = []

		(1..n).each do |i|
			exceution_time = rand(min_exection_time..max_exection_time)
			process = [i, 0, exceution_time]
			batch << process
		end

		puts batch.to_s

	end
end

def produce_alternate_cases(count)
	(count).times do
		batch = []

		(1..n).each do |i|
			if i%2==0
				exceution_time = max_exection_time
			else
				exceution_time = min_exection_time
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

		lower = min_exection_time + (max_exection_time - min_exection_time)/3
		upper = max_exection_time - (max_exection_time - min_exection_time)/3

		(1..n).each do |i|
			if i%2==0
				exceution_time = rand(min_exection_time..lower)
			else
				exceution_time = rand(min_exection_time..upper)
			end
			process = [i, 0, exceution_time]
			batch << process
		end

		puts batch.to_s
	end
end

def all_small(count)
	count.times do
		(1..n).each do |i|
			exceution_time = min_exection_time
			process = [i, 0, exceution_time]
			batch << process
		end

		puts batch.to_s
	end
end

def all_big(count)
	count.times do
		(1..n).each do |i|
			exceution_time = max_exection_time
			process = [i, 0, exceution_time]
			batch << process
		end

		puts batch.to_s
	end
end
