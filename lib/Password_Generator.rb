#!/usr/bin/env ruby

class Password_Generator
	def initialize length
		@@letters = ('a'..'z').to_a 
		@@upper = ('A'..'Z').to_a
		@@numbers = (0..9).to_a
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
		password = []
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

	def make_simple
		self.make_custom({:letters => true, :spacing => 3, :joiner => '-'})
	end

	def make_custom args
		want_number  = args[:numbers]  #bool
		want_letter  = args[:letters]  #bool
		want_upper   = args[:upper]    #bool
		want_special = args[:specials] #bool
		joiner       = args[:joiner]   #char
		spacing      = args[:spacing]  #int

		password = []
		chars = []

		if joiner && !spacing
			puts "Need spacing."
			exit(-1)
		end
		if !joiner && spacing
			puts "Need joiner."
			exit(-1)
		end
		if want_number
			chars += @@numbers
		end
		if want_letter
			chars += @@letters
		end
		if want_upper
			chars += @@upper
		end
		if want_special
			chars += @@specials
		end

		if spacing
			@length -= @length % spacing
			@length /= spacing
			@length.times do |i|
				i += 1
				spacing.times do
					password.push chars[rand chars.length]
				end
				password.push joiner
			end
			password.pop
		else
			@length.times do
				password.push chars[rand chars.length]
			end
		end
		password.join
	end
end

# Example
if __FILE__ == $0

	my_pass = Password_Generator.new ARGV[0].to_i
	puts my_pass.make_custom({numbers: true, letters: true, spacing:4, joiner:','})

end
