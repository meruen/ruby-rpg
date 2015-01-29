# encoding: utf-8
# camera.rb

class Camera
	attr_reader :offset_x, :offset_y
	attr_accessor :x, :y

	def initialize(x = 0, y = 0)
		move x, y
	end
	
	def move(x, y)
		@x = x
		@y = y
	end
end
