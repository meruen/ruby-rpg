# encoding: utf-8

load 'action.rb'

class WaitForKey < Action
	attr_accessor :key
	attr_accessor :handle

	def initialize(handle ,key)
		super nil
		@handle = handle
		@key = key
	end

	def update
		super
		finish if @handle.button_down? @key
	end
end
