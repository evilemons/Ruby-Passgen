#!/usr/bin/ruby

class Password_Generator
	def initialize length
		@@letters = ('a'..'z').to_a
		@@all = @@letters + (1..9).to_a
		@length = length
	end

	def rand_num
		rand 9
	end

	def rand_let
		@@letters[rand(@@letters.length)]
	end

	def make
		password = Array.new
		@length.times do 
			let = rand(0..1)
			if let == 1
				password.push self.rand_let
			else
				password.push self.rand_num
			end
		end
		password.join
	end
end

# Example
if __FILE__ == $0

my_pass = Password_Generator.new ARGV[0].to_i
p = my_pass.make
puts p

end
