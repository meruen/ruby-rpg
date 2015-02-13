# encoding: utf-8

require 'gosu'
load 'character.rb'
load 'map.rb'
load 'camera.rb'
load 'event.rb'
load 'cursor.rb'
load 'action/message.rb'
load 'action/condition.rb'
load 'action/codeblock.rb'
load 'action/move_event.rb'
load 'action/fade.rb'

VERSION ||= '0.2.2'

# This is the main Class for an ruby-rpg project. It's here that all the magic begins. 
class Gamebox < Gosu::Window
	# @return [Map] Current map.
	attr_accessor :map
	# @return [Hash] Hash containing all the maps of your project. Append your maps here.
	attr_accessor :maps
	# @return [Fixnum] Screen Width.
	attr_reader :screen_w
	# @return [Fixnum] Screen Height.
	attr_reader :screen_h
	# @return [Fixnum] Luminosity of screen (0...255).
	attr_accessor :light
	# @return [Cursor] Cursor.
	attr_accessor :cursor

	# @param [Fixnum] screen_w Screen width.
	# @param [Fixnum] screen_h Screen height.
	# @param [Fixnum] light Luminosity of screen (0...255).
	# @param [true/fase] fullscreen True if it's fullscreen.
	def initialize(screen_w = 640, screen_h = 480, light = 0, fullscreen = false)
		super screen_w, screen_h, fullscreen
		@screen_w = screen_w
		@screen_h = screen_h
		@light = light
		@maps = Hash.new 
		puts "Everything is up! ruby-rpg version #{VERSION}"
	end

	# Update your game.
	# @return [void]
	def update
		@cursor.update if @cursor != nil
		@map.update if @map != nil		
		@light_color = Gosu::Color.new @light, 0, 0, 0
	end

	# Draw the content of your game.
	# @return [void]
	def draw
		@cursor.draw if @cursor != nil
		@map.draw if @map != nil
		self.draw_quad 0, 0, @light_color, @screen_w, 0, @light_color, 0, @screen_h, @light_color, @screen_w, @screen_h, @light_color, 2
	end
end
