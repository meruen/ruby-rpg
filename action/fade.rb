# encoding: utf-8

require 'gosu'

load 'action.rb'
load 'timer.rb'

module Act
	class Fade < Action
		IN = 0 unless defined? IN
		OUT = 255 unless defined? OUT

		attr_accessor :style
		attr_accessor :speed

		def initialize(handle, light, speed = 100)
			super handle, nil
			@speed = speed
			@light = light
			prepare
		end	

		def prepare
			@timer = Timer.new @speed
			if @handle.light > @light 
				@style = Act::Fade::OUT
			else 
				@style = Act::Fade::IN
			end
			self.finished = false
		end

		def update
			super
			if @timer.reached?				
				increment = (@handle.light > @light ? -1 : 1)
				if @handle.light == @light then finish else @handle.light += increment end
			end
		end
	end
end
