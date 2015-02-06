# encoding: utf-8

require 'gosu'
load 'action.rb'
load 'timer.rb'
load 'frame.rb'

module Act
	# This class serves to show messages in order.
	class Message < Action
		# @return [String] Text to display.
		attr_accessor :txt
		# @return [Gamebox] Main Gamebox.
		attr_accessor :handle
		# @return [Integer] Speed of message.
		attr_accessor :speed
		# @return [Frame] Frame that will be displayed.
		attr_accessor :frame
		# @return [MessagePosition] Message position.
		attr_accessor :position
	
		IDLE ||= 0
		BACKGROUND_SHOWING ||= 1
		BACKGROUND_SHOWED ||= 2
		TEXT_DRAWING ||= 3
		TEXT_DRAWED ||= 4
	
		CENT ||= 0
		TOP ||= 0
		BOT ||= 340

		# @param [Gamebox] handle Main Gamebox.
		# @param [String] txt Text to display.
		# @param [Integer] speed Speed of message.
		# @param [MessagePosition] position Message position.
		def initialize(handle, txt, speed = 80, position = BOT)
			super handle, nil
			@handle = handle
			@font = Gosu::Font.new @handle, 'Liberation Mono', 24
			@text_to_show = ''
			@speed = speed
			@timer = Timer.new speed
			@txt = txt
			@frame = Frame.new handle, 0, Message::BOT, 640, 140
			@state = TEXT_DRAWING
		end

		# Internal function to rebuild all the content of message.
		# @return [void]
		def rebuild
			@text_to_show = ''
			self.finished = false
		end

		# Update the message content and display letter-by-letter.
		# @return [void]
		def update
			super
			if self.finished
				rebuild
			else
				@text_to_show = '' and finish and return if @text_to_show == @txt && @handle.button_down?(Gosu::KbX)
				return if @text_to_show == @txt
				@text_to_show << @txt[@text_to_show.length] if @timer.reached?
			end
		end

		# Draw the message on screen.
		# @param [Camera] camera Main Camera of your project.
		# @return [void]
		def draw(camera)
			super camera
			@frame.draw
			@font.draw @text_to_show, 16, Message::BOT + 16, 0
		end
	end
end
