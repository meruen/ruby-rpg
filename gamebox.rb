# encoding: utf-8

require 'gosu'
load 'character.rb'
load 'map.rb'
load 'camera.rb'
load 'event.rb'
load 'action/message.rb'
load 'action/condition.rb'
load 'action/eval.rb'
load 'action/codeblock.rb'
load 'action/move_event.rb'

APPNAME ||= 'Justice League: Silence of the Lambs'
VERSION ||= '0.0.2a'

class Gamebox < Gosu::Window
	attr_accessor :map
	attr_accessor :screen_w
	attr_accessor :screen_h

	def initialize
		super 640, 480, false
		@screen_w = 640
		@screen_h = 480
		self.caption =  "#{APPNAME} #{VERSION}"
		@map = Map.new self, 'map/map01generic.map', 'res/chip/town08a.png', 30, 16, 'res/chip/map01.png', true
		@c = Character.new self, 'res/char/superman_prime_01.png', 4, 256, 256
		@ev = Event.new self, 'res/char/superman.png', 4, 6 * Map::TILE_SIZE, 5 * Map::TILE_SIZE
				@ev.action_manager.push Condition.new self, '15 == 15', [(Message.new self, 'Parece que deu certo... '), (Message.new self, 'E concatena!'), 
(MoveEvent.new self, @ev, 3, Direction::RIG, 2)
]
		@map.events.push @ev
		@map.characters.push @c
	end

	def update
		@map.update
	end

	def draw
		@map.draw
	end
end
