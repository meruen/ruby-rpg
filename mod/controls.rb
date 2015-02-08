# encoding: utf-8

require 'gosu'

module Controls
	module Kb
		LEFT = Gosu::KbLeft unless defined? LEFT
		RIGHT = Gosu::KbRight unless defined? RIGHT
		UP = Gosu::KbUp unless defined? UP
		DOWN = Gosu::KbDown unless defined? DOWN

		ACT = Gosu::KbZ unless defined? ACT
		RUN = Gosu::KbX unless defined? RUN
	end

	module Jp
		LEFT = Gosu::GpLeft unless defined? LEFT
		RIGHT = Gosu::GpRight unless defined? RIGHT
	       	UP = Gosu::GpUp unless defined? UP
		DOWN = Gosu::GpDown unless defined? DOWN

 		ACT = Gosu::GpButton0 unless defined? ACT	 
       		RUN = Gosu::GpButton1 unless defined? RUN
	end
end


