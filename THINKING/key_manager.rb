# encoding: utf-8

load 'key.rb'

class KeyManager
	attr_accessor :map

	def initialize(handle)
		@handle
		@map = Hash.new
	end

	def check_current
		@map.keys.each do |key|
			@map[key].gosu_state = @hande.button_down?(@map[key].gosukey)
		end
	end

	def set_current

	end

	def push(hashname, key)
		@map[hashname] = key
	end	
end
