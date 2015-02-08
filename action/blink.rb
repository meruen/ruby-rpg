# encoding: utf-8

require 'gosu'

load 'action.rb'

module Act
	class Blink < Action
		def initialize(handle, increment = 1)
			super handle, nil
			@increment = increment
			prepare
		end	

		def prepare
			@a = 255
			@color = Gosu::Color.new @a, 0, 0, 0
			@img = Gosu::Image.new @handle, 'res/sys/fade.png', false
			self.finished = false
		end

		def update
			super
			puts @a
			if @a <= 0 then finish else @color = Gosu::Color.new((@a -= @increment), 0, 0, 0) end
		end

		def draw(camera)
			super(camera)
			@img.draw(0, 0, 1, 1, 1, @color) if @img != nil
		end

		def finish
			super
			@img = nil
		end
	end
end
