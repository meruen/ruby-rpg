# encoding: utf-8

class Profile
	attr_accessor :atk, :def, :hp, :max_hp, :gauge, :max_gauge, :lv, :max_lv, :luk

	def initialize

	end

	def recover(ammount)
		@hp += ammount
		@hp = @max_hp if @hp > @max_hp
	end
end
