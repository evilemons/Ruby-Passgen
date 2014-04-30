#!/usr/bin/env ruby

class Password_Generator
	@@letters = ('a'..'z').to_a 
	@@upper = ('A'..'Z').to_a
	@@numbers = (0..9).to_a
	@@specials = %w(` ~ @ # $ % ^ & * ( ) _ + { } | : ; [ ] \ ' " , < > . / ?)
	@@all = @@letters + (0..9).to_a + @@specials

	def initialize length
		@length = length
	end

	def rand_num
		rand (0..9)
	end

	def rand_let
		@@letters[rand @@letters.length]
	end

	def rand_spec
		@@specials[rand @@specials.length]
	end

	def make_complex
		self.make_custom({letters: true, numbers: true, upper: true, specials: true})
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

		if joiner
			unless spacing
				puts "Need spacing"
				exit -1
			end
		end
		if spacing
			unless joiner
				puts "Need joiner"
				exit -1
			end
		end

		password = []
		chars = []

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
			@length.times do 
				spacing.times do
					password.push chars[rand chars.length]
				end
				password.push joiner
			end
			password.pop
		else
			@length.times do
				if chars.count == 0
					password.push @@all[rand @@all.length]
				else
					password.push chars[rand chars.length]
				end
			end
		end
		password.join
	end
end

# Example
if __FILE__ == $0

	my_pass = Password_Generator.new ARGV[0].to_i
	#puts my_pass.make_custom({numbers: false, letters: true, upper: false, spacing: 3, joiner: '-'})
	puts my_pass.make_complex

end
