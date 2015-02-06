# encoding: utf-8

# Template to data profile of Character.
class Profile
	# @return [Integer] Atack.
	attr_accessor :atk
	# @return [Integer] Defense.
	attr_accessor :def
	# @return [Integer] Health.
	attr_accessor :hp
	# @return [Integer] Max Health.
	attr_accessor :max_hp
	# @return [Integer] Chain gauge.
	attr_accessor :gauge
	# @return [Integer] Max Chain Gauge.
	attr_accessor :max_gauge
	# @return [Integer] Lv.
	attr_accessor :lv
	# @return [Integer] Max Lv.
	attr_accessor :max_lv
	# @return [Integer] Luck.
	attr_accessor :luk

	def initialize

	end

	# Recover ammount of Health.
	# @param [Integer] ammount Ammount.
	# @return [void]
	def recover(ammount)
		@hp += ammount
		@hp = @max_hp if @hp > @max_hp
	end
end
