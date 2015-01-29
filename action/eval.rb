# encoding: utf-8

class Eval < Action
	attr_accessor :str

	def initialize(handle, str)
		super(handle, nil)
		@str = str
	end

	def update
		eval str
		finish
	end
end
