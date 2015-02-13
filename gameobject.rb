# encoding: utf-8

require 'gosu'

class GameObject
	attr_accessor :x
	attr_accessor :y	
	attr_accessor :handle

	def initialize(handle, x = 0, y = 0)
		@handle = handle
		@x = x
		@y = y
	end

	def update

	end

	def draw

	end
end
