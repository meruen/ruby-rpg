# encoding: utf-8
# map.rb

require 'gosu'
load 'camera.rb'
load 'mod/Direction.rb'
load 'mod/tile.rb'

class Map
	attr_reader :chip, :w, :h
	attr_accessor :events, :camera, :characters

	ZMAP = -2
	ZEV_BOT = 1
	ZEV_TOP = -1
	ZCHAR = 0		
	TILE_SIZE ||= 32

	def initialize(handle, filename, chip, rows, cols, background = nil, only_background = false)
		@camera = Camera.new
		@handle = handle
		@filename = filename
		@chip = chip
		@rows = rows
		@cols = cols
		@w = cols * TILE_SIZE
		@h = rows * TILE_SIZE
		@events = Array.new
		@map_rows = Array.new	
		@map_file = File.new filename, 'r'
		@map_file.each_line do |line|  
			all = Array.new
			#a = line.split ' '
			#a.each do |cmd| all << (cmd.split '-') end
			line.each_char do |c| all.push [0, c] end
			@map_rows.push all
		end
		@background = nil
		@background = Gosu::Image.new handle, background if background != nil
		@back_w = @background.width if background != nil
		@back_h = @background.height if background != nil
		@only_background = only_background
		@map_file.close
		@strip = Gosu::Image.load_tiles @handle, chip, TILE_SIZE, TILE_SIZE, true
		@characters = Array.new

		@key_x = @handle.button_down? Gosu::KbX
		@last_key_x = @key_x
	end

	def update
		@key_x = @handle.button_down? Gosu::KbX
		@events.each do |event|	event.update 
			event.z = ZEV_BOT if event.y > @characters[0].y
			event.z = ZEV_TOP if event.y < @characters[0].y						

			if @key_x && !@last_key_x && colliding?(@characters[0], event)
				event.on_press @characters[0].direction
			end
		end
		@characters.each do |character| character.update end
		#if @cols > 10
			xp = @characters[0].x	
			yp = @characters[0].y
			if xp > @back_w - (@handle.screen_w / 2)
				@camera.x = @back_w - @handle.screen_w
			elsif xp > @handle.screen_w / 2
				@camera.x = - ((@handle.screen_w / 2) - xp)
			end

			if yp > @back_h - (@handle.screen_h / 2)
				@camera.y = @back_h - @handle.screen_h
			elsif yp > @handle.screen_h / 2
				@camera.y = - ((@handle.screen_h / 2) - yp)
			end
		#end
		@last_key_x = @key_x
	end

	def draw
		@background.draw 0 - @camera.x, 0 - @camera.y, ZMAP if @background != nil
		if not @only_background
			@map_rows.each_index do |row_index|
				@map_rows[row_index].each_index do |col_index|
					@strip[@map_rows[row_index][col_index][Tile::VALUE].to_i].draw (col_index * TILE_SIZE) - @camera.x, (row_index * TILE_SIZE) - @camera.y, 0
				end
			end	
		end
		
		@characters.each do |character| character.draw end
		@events.each do |event| event.draw end
	end

	def colliding?(char, event)
		case char.direction
			when Direction::TOP
				return true if event.y == char.y - TILE_SIZE && event.x == char.x
			when Direction::BOT
				return true if event.y == char.y + TILE_SIZE && event.x == char.x
			when Direction::LEF
				return true if event.y == char.y && event.x == char.x - TILE_SIZE
			when Direction::RIG
				return true if event.y == char.y && event.x == char.x + TILE_SIZE
		end
		return false
	end

	def can_advance?(x, y, direction)
		return true if x % TILE_SIZE != 0 || y % TILE_SIZE != 0	
		block_x = x / TILE_SIZE
		block_y = y / TILE_SIZE

		case direction
			when Direction::TOP
				return false if block_y <= 0 || @map_rows[block_y - 1][block_x][Tile::TYPE] == Tile::BLOCK
				@events.each do |event| return false if event.y == @characters[0].y - TILE_SIZE && event.x == @characters[0].x end
			when Direction::BOT
				return false if @map_rows[block_y + 1] == nil  || @map_rows[block_y + 1][block_x][Tile::TYPE] == Tile::BLOCK
				@events.each do |event| return false if event.y == @characters[0].y + TILE_SIZE && event.x == @characters[0].x end 
			when Direction::LEF
				return false if block_x <= 0 || @map_rows[block_y][block_x - 1][Tile::TYPE] == Tile::BLOCK
				@events.each do |event| return false if event.y == @characters[0].y && event.x == @characters[0].x - TILE_SIZE end
			when Direction::RIG
				return false if @map_rows[block_y][block_x + 2 ] == nil || @map_rows[block_y][block_x + 1][Tile::TYPE] == Tile::BLOCK
				@events.each do |event| return false if event.y == @characters[0].y && event.x == @characters[0].x + TILE_SIZE end
			else
				puts '[ERROR] Invalid Direction'
		end 	
		return true	
	end
end
