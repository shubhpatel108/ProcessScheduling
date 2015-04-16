module TypesOfCases

	def produce_random_cases(count=1)
		all_batches = []
		(count).times do
			batch = []

			(1..@n).each do |i|
				exceution_time = rand(@min_exection_time-1..@max_exection_time)
				process = [i, 0, exceution_time, exceution_time]
				batch << process
			end

			all_batches << batch
		end
		return all_batches
	end

	def produce_alternate_cases(count=1)
		all_batches = []
		(count).times do
			batch = []

			(1..@n).each do |i|
				if i%2==0
					exceution_time = @max_exection_time
				else
					exceution_time = @min_exection_time
				end
				process = [i, 0, exceution_time, exceution_time]
				batch << process
			end

			all_batches << batch
		end
		return all_batches
	end

	def produce_loose_alternate(count=1)
		all_batches = []
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
				process = [i, 0, exceution_time, exceution_time]
				batch << process
			end

			all_batches << batch
		end
		return all_batches
	end

	def all_small(count=1)
		all_batches = []
		count.times do
			batch = []
			(1..@n).each do |i|
				exceution_time = @min_exection_time
				process = [i, 0, exceution_time, exceution_time]
				batch << process
			end

			all_batches << batch
		end
		return all_batches
	end

	def all_big(count=1)
		all_batches = []
		count.times do
			batch = []
			(1..@n).each do |i|
				exceution_time = @max_exection_time
				process = [i, 0, exceution_time, exceution_time]
				batch << process
			end

			all_batches << batch
		end
		return all_batches
	end

	def increasing
		all_batches = []
		multiplier = (@max_exection_time.to_f - @min_exection_time.to_f)/@n
		batch = []

		(1..@n).each do |i|
			exceution_time = (@min_exection_time + multiplier*(i)).to_i
			process = [i, 0, exceution_time, exceution_time]
			batch << process
		end

		all_batches << batch
		return all_batches
	end

	def decreasing
		all_batches = []
		multiplier = (@max_exection_time.to_f - @min_exection_time.to_f)/@n
		batch = []

		(1..@n).each do |i|
			exceution_time = (@max_exection_time - multiplier*(i-1)).to_i
			process = [i, 0, exceution_time, exceution_time]
			batch << process
		end

		all_batches << batch
		return all_batches
	end

	def random_alternate(count=1)
		all_batches = []
		min = rand(@min_exection_time..@max_exection_time)
		
		count.times do
			batch = []
			(1..@n).each do |i|
				if i%2==0
					exceution_time = rand(min..@max_exection_time)
					min = exceution_time
				else
					exceution_time = rand(@min_exection_time-1..min)
					min = exceution_time
				end
				process = [i, 0, exceution_time, exceution_time]
				batch << process
			end
			all_batches << batch
		end

		return all_batches
	end

	def read_input(filename, processes)
        if File.exists?(filename)
            f = File.open(filename, "r")
            f.each_line do |line|
                values = line.split(" ")
                values << values[2]
                processes.push(values.map {|i| i.to_i})
            end
            f.close
        end
    end

    def print_processes(processes)
        processes.each do |x|
            x.each do |y|
                print y
                print " "
            end
            puts "\n"
        end
    end

    def shortest_job_first(processes)
        #read_input("test.txt", processes)
        num_processes = processes.length
        ready_queue = processes.sort {|left, right| right[2] <=> left[2]}
        total_response_time = 0.0
        total_waiting_time = 0.0
        total_turn_around_time = 0.0
        time = 0.0
        while not ready_queue.empty?
            current_process = ready_queue[ready_queue.length-1]
            total_response_time = total_response_time + time - current_process[1]
            time = time + current_process[2]
            total_waiting_time = total_waiting_time + time - current_process[2] - current_process[1]
            total_turn_around_time = total_turn_around_time + time - current_process[1]
            ready_queue.pop()
        end
        print "SJF: \n"
        print "Average waiting time: "
        print total_waiting_time/num_processes
        puts "\n"
        print "Average response time: "
        print total_response_time/num_processes
        puts "\n"
        print "Average turn around time: "
        print total_turn_around_time/num_processes
        puts "\n"
        print "--------------------------------------------\n"
        return [total_waiting_time/num_processes, total_response_time/num_processes, total_turn_around_time/num_processes]
    end

    def shortest_remaining_time_first(processes)
        #read_input("test.txt", processes)
        num_processes = processes.length
        ready_queue = processes.sort {|left, right| left[2] <=> right[2]}
        total_response_time = 0.0
        total_waiting_time = 0.0
        total_turn_around_time = 0.0
        time = 0.0
        while not ready_queue.empty?
            current_process = ready_queue[0]
            if current_process[2] == current_process[3]
                total_response_time = total_response_time + time - current_process[1]
            end
            time = time + 1
            current_process[3] = current_process[3] - 1
            if current_process[3] == 0
                total_waiting_time = total_waiting_time + time - current_process[2] - current_process[1]
                total_turn_around_time = total_turn_around_time + time - current_process[1]
                ready_queue.delete_at(0)
            else
                1.upto(ready_queue.length-1) do |index|
                    if current_process[3] <= ready_queue[index][3]
                        ready_queue.insert(index, ready_queue.delete_at(0))
                    end
                end
            end
        end
        print "SRTF: \n"
        print "Average waiting time: "
        print total_waiting_time/num_processes
        puts "\n"
        print "Average response time: "
        print total_response_time/num_processes
        puts "\n"
        print "Average turn around time: "
        print total_turn_around_time/num_processes
        puts "\n"
        print "--------------------------------------------\n"
        return [total_waiting_time/num_processes, total_response_time/num_processes, total_turn_around_time/num_processes]
    end

    def first_come_first_serve(processes)
        #read_input("test.txt", processes)
        processes.sort!{|proc1, proc2| proc1[1] <=> proc2[1]}
        turn_around_time = 0.0
        response_time = 0.0
        current_time = 0.0
        for i in 0..(processes.length-1)
          response_time += current_time - processes[i][1]
          for j in 1..processes[i][2]
            current_time += 1
            # print "Current Time : #{current_time} Process in execution : #{processes[i][0]}\n"
          end
        turn_around_time = turn_around_time + current_time
        end
        print "first come first serve: \n"
        # print "Average waiting time: "
        # print total_waiting_time/num_processes
        # puts "\n"
        print "Average response time: "
        print response_time/processes.length
        puts "\n"
        print "Average turn around time: "
        print turn_around_time/processes.length
        puts "\n"
        print "Total time: "
        print current_time
        puts "\n"
        print "--------------------------------------------\n"
        return [0.0, response_time/processes.length, turn_around_time/processes.length]
    end

    def round_robin(processes, time_quanta, context_switch)
        #read_input("test.txt", processes)
        processes.sort!{|proc1, proc2| proc1[1] <=> proc2[1]}
        turn_around_time = 0.0
        response_time = 0.0
        n = processes.length
        current_time = 0.0
        i = 0
        while true
          j = 1
          if processes[i][2] == processes[i][3]
            response_time += current_time - processes[i][1]
          end
          while j <= time_quanta and j <= processes[i][3]
            current_time += 1
            # print "Current Time : #{current_time} Process in execution : #{processes[i][0]}\n"
            j += 1
          end
          processes[i][3] -= time_quanta
          if processes[i][3] <= 0
            turn_around_time += current_time - processes[i][1]
            processes.delete_at(i)
            i = (i-1) 
          end
          break if processes.empty?
          current_time += context_switch
          i = (i+1)%processes.count
        end
        print "Round Robin: \n"
        # print "Average waiting time: "
        # print total_waiting_time/num_processes
        # puts "\n"
        print "Average response time: "
        print response_time/n
        puts "\n"
        print "Average turn around time: "
        print turn_around_time/n
        puts "\n"
        print "Total time: "
        print current_time
        puts "\n"
        print "--------------------------------------------\n"
        return [0.0, response_time/n, turn_around_time/n]
    end
	
end
