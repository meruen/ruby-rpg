# encoding: utf-8

require 'gosu'

# Amazing class that build frames without resources.
class Frame
	# @return [Gamebox] Main Gamebox.
	attr_accessor :handle
	# @return [Integer] X coordinate.
	attr_accessor :x
	# @return [Integer] Y coordinate.
	attr_accessor :y
	# @return [Integer] Width.
	attr_accessor :w
	# @return [Integer] Height.
	attr_accessor :h
	# @return [Integer] Z order.
	attr_accessor :z
	# @return [Integer] Alpha value.
	attr_accessor :a

	# @param [Gamebox] handle Main Gamebox.
	# @param [Integer] x X coordinate.
	# @param [Integer] y Y coordinate.
	# @param [Integer] w Width.
	# @param [Integer] h Height.
	# @param [Integer] a Alpha value.
	# @param [Integer] z Z order.
	def initialize(handle, x, y, w, h, a = 255, z = 0)
		@handle = handle	
		@x = x
		@y = y
		@w = w
		@h = h
		@a = a
		@z = z
		colors
	end

	# Build the colorset.
	# @return [void]
	def colors
		@white = Gosu::Color.new @a, 255, 255, 255
		@blue_border = Gosu::Color.new @a, 33, 35, 79
		@blue1 = Gosu::Color.new @a, 66, 68, 120
		@blue2 = Gosu::Color.new @a, 56, 58, 110
		@blue3 = Gosu::Color.new @a,40, 41, 81
		@blue_text = Gosu::Color.new @a, 192, 224, 255

		@green_light = Gosu::Color.new @a, 0, 255, 0
		@green_dark = Gosu::Color.new @a, 0, 100, 0
		@blue_light = Gosu::Color.new @a, 0, 0, 255
		@blue_dark = Gosu::Color.new @a, 0, 0, 100
		@black = Gosu::Color.new @a, 0, 0, 0
		@grey = Gosu::Color.new @a, 50, 50, 50
	end

	# Draw the Frame content.
	# @return [void]
	def draw
		# blue border
		@handle.draw_quad(@x, @y, @blue_border, @x + @w, @y, @blue_border, @x, @y + @h, @blue_border, @x + @w, @y + @h, @blue_border, @z)     
		# white border
		@handle.draw_quad(@x + 1, @y + 1, @white, @x + @w - 1, @y + 1, @white, @x + 1, @y + @h - 1, @white, @x + @w - 1, @y + @h - 1, @white, @z)    
		# blue gradient
		@handle.draw_quad(@x + 3, @y + 3, @blue1, @x + @w - 3, @y + 3, @blue2, @x + 3, @y + @h - 3, @blue2, @x + @w - 3, @y + @h - 3, @blue3, @z) 
	end
end
