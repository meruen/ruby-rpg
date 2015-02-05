# encoding: utf-8

# Camera serves to give relative on-screen coordinates for the child drawable components inside a Map.
class Camera
	# @return [Integer] the offset window-based X coordinate
	attr_accessor :x
	# @return [Integer] the offset window-based Y coordinate
	attr_accessor :y

	# @param [Integer] x X coordinate
	# @param [Integer] y Y coordinate
	def initialize(x = 0, y = 0)
		move x, y
	end

	# Set the camera coordinates
	#   @return [nil]	
	def move(x, y)
		@x = x
		@y = y
	end
end
