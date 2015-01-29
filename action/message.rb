# encoding: utf-8

require 'gosu'
load 'action.rb'
load 'timer.rb'

class Message < Action
	attr_accessor :txt, :handle
	attr_accessor :speed, :background, :position
	
	IDLE ||= 0
	BACKGROUND_SHOWING ||= 1
	BACKGROUND_SHOWED ||= 2
	TEXT_DRAWING ||= 3
	TEXT_DRAWED ||= 4
	
	CENT ||= 0
	TOP ||= 0
	BOT ||= 340

	def initialize(handle, txt, speed = 80, position = BOT)
		super handle, nil
		@handle = handle
		@font = Gosu::Font.new @handle, 'Liberation Mono', 24
		@text_to_show = ''
		@speed = speed
		@timer = Timer.new speed
		@txt = txt
		@background = Gosu::Image.new @handle, 'res/sys/messagebox.png', false
		#@background = background
		@state = TEXT_DRAWING
	end

	def rebuild
		@text_to_show = ''
		self.finished = false
	end

	def update
		super
		#if self.finished
		#	@text_to_show = ''
		#	self.finished = false
		#else
		#	case @state
		#		when TEXT_DRAWING
					#@state = TEXT_DRAWED and return false if @text_to_show == @txt
		#			@text_to_show << @txt[@text_to_show.length] if @timer.reached?		
		#			@state = TEXT_DRAWED and return false if @text_to_show == @txt
		#		when TEXT_DRAWED
		#			finish and return false if @handle.button_down? Gosu::KbX
		#		else
		#	end
		#end
		if self.finished
			rebuild
		else
			@text_to_show = '' and finish and return if @text_to_show == @txt && @handle.button_down?(Gosu::KbX)
			return if @text_to_show == @txt
			@text_to_show << @txt[@text_to_show.length] if @timer.reached?
		end
	end

	def draw(camera)
		super camera
		@background.draw 0, Message::BOT, 0
		@font.draw @text_to_show, 16, Message::BOT + 16, 0
	end
end
