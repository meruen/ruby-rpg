# encoding: utf-8

load 'gamebox.rb'
load 'frame.rb'
load 'jazz.rb'
load 'cursor.rb'

module Examples
	class Example01 < Gamebox
		def initialize
			super
			# Change title of project.
	        self.caption =  'Example01'
			# Create the main map.
        	self.map = Map.new self, 'map/map01generic.map', 'res/chip/town08a.png', 30, 16, 'res/chip/map01.png', true
			# Initializes Jazz... Responsible for all project sound resources.
			@jazz = Jazz.new self, 'res/bgm', 'res/se'
			# Play mm2.ogg
			@jazz.play_bgm 'mm2'
			# Create a custom cursor
			self.cursor = Cursor.new self, 'res/sys/cursor32.png'
			
			# Create the main Character
			character = Character.new self, 'res/char/superman_prime_01.png', 4, 256, 256
			# Create 2 events.
	        ev001 = Event.new self, 'res/char/superman.png', 4, 6 * Map::TILE_SIZE, 5 * Map::TILE_SIZE
			ev002 = Event.new self, 'res/char/superman.png', 4, 3 * Map::TILE_SIZE, 4 * Map::TILE_SIZE

			# Add some actions to the ev001 action manager.
			ev001.action_manager.push Act::Message.new(self, 'Move')
			ev001.action_manager.push Act::Message.new(self, 'abc')
			ev001.action_manager.push Act::Codeblock.new(self, Proc.new do 
				$sw_1 = true
			end)
	
			# Add a condition to ev002
			ev002.action_manager.push Act::Condition.new(self, '$sw_1 == true', [ # if $sw_1 is 'true' then
				Act::Message.new(self, 'Dark...'), 
				Act::Fade.new(self, 255), 
				Act::Fade.new(self, 0)
			], [ # else
				Act::Message.new(self, 'teste'), 
				Act::Message.new(self, '...')
			]) # end

			# Add the events to the map.
        	self.map.events.push ev001
			self.map.events.push ev002
			# Add the character to the map.
        	self.map.characters.push character
		end
	end
end

Examples::Example01.new.show
