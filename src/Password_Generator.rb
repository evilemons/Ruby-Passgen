#!/usr/bin/ruby

class Password_Generator
	def initialize length
		@@letters = ('a'..'z').to_a + ('A'..'Z').to_a
		@@specials = %w(` ~ @ # $ % ^ & * ( ) _ + { } | : ; [ ] \ ' " , < > . / ?)
		@@all = @@letters + (1..9).to_a + @@specials
		@length = length
	end

	def rand_num
		rand 9
	end

	def rand_let
		@@letters[rand @@letters.length]
	end

	def rand_spec
		@@specials[rand @@specials.length]
	end

	def make_complex
		password = Array.new
		@length.times do 
			let = rand(0..2)
			if let == 1
				password.push self.rand_let
			elsif let == 2
				password.push self.rand_num
			else
				password.push self.rand_spec
			end
		end
		password.join
	end
end

# Example
if __FILE__ == $0

my_pass = Password_Generator.new ARGV[0].to_i
puts my_pass.make_complex

end
