# encoding: utf-8

load 'action.rb'
load 'timer.rb'
load 'mod/ctime.rb'

class Wait < Action
	attr_accessor :interval

	def initialize(handle, interval)
		super handle, nil
		@interval = interval
		@timer = Timer.new interval
		prepare
	end

	def update
		super
		finish if @timer.reached?	
	end
end
