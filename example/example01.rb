# encoding: utf-8

load 'gamebox.rb'
load 'frame.rb'

module Examples
	class Example01 < Gamebox
		def initialize
			super
	        self.caption =  'Example01'
        	self.map = Map.new self, 'map/map01generic.map', 'res/chip/town08a.png', 30, 16, 'res/chip/map01.png', true

    	    character = Character.new self, 'res/char/superman_prime_01.png', 4, 256, 256
	        ev001 = Event.new self, 'res/char/superman.png', 4, 6 * Map::TILE_SIZE, 5 * Map::TILE_SIZE
        	ev001.action_manager.push Act::Message.new(self, 'This is an example to use class Message...')
			ev001.action_manager.push Act::Message.new(self, 'And understand a bit the ActionManager.')

	        self.map.events.push ev001
        	self.map.characters.push character
		end

		def draw
			super
		end
	end
end

Examples::Example01.new.show
