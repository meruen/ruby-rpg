# encoding: utf-8

require './action/move_event.rb'

module Act
	class MoveSequence < ActionManager
		attr_accessor :event		

		def initialize(handle, event, str)
			super handle, nil
			@event = event
			str.each_char do |c|
				dir = case c
						when 'U' then Direction::TOP
						when 'D' then Direction::BOT
						when 'L' then Direction::LEF
						when 'R' then Direction::RIG
				end
				self.push MoveEvent.new(handle, event, 1, dir)
			end
		end

		def prepare
			super
			restart	
		end

		def update
			super
			puts @current_action
		end
	end
end
