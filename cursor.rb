# encoding: utf-8

require './gameobject.rb'

class Cursor < GameObject
	attr_accessor :visible

	def initialize(handle, filename, visible = true)
		super handle
		@img = Gosu::Image.new handle, filename, false
	end

	def update
		self.x = self.handle.mouse_x
		self.y = self.handle.mouse_y
	end

	def draw
		@img.draw self.x, self.y, 5
	end	
end
