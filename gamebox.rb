# encoding: utf-8

require 'gosu'
load 'character.rb'
load 'map.rb'
load 'camera.rb'
load 'event.rb'
load 'action/message.rb'
load 'action/condition.rb'
load 'action/codeblock.rb'
load 'action/move_event.rb'

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

	def initialize
		super 640, 480, false
		@screen_w = 640
		@screen_h = 480
		@maps = Hash.new
	end

	# Update your game.
	# @return [void]
	def update
		@map.update if @map != nil
	end

	# Draw the content of your game.
	# @return [void]
	def draw
		@map.draw if @map != nil
	end
end
