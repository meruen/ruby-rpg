# encoding: utf-8

require 'gosu'

# Songs and Soud Effects manager.
class Jazz
	# @return [Hash] BGM hash.
	attr_accessor :bgm
	# @return [Gamebox] Main Gamebox.
	attr_accessor :handle
	# @return [Gosu::Song] Current BGM playing.
	attr_reader :bgm_playing
	# @return [Hash] SE hash.
	attr_accessor :se

	# @param [Gamebox] handle Main Gamebox.
	# @param [String] bgm_path BGM directory.
	# @param [String] se_path SE directory.
	def initialize(handle, bgm_path, se_path)
		@handle = handle
		@bgm = Hash.new
		@se = Hash.new
		load_directory bgm_path, se_path
	end

	# Play a bgm from BGM hash.
	# @param [String] bgm BGM name (exactly filename without extension).
	# @param [true/false] looping Play in loop.
	# @return [true/false] True if play.
	def play_bgm(bgm, looping = false)
		if @bgm[bgm] != nil
			if Gosu::Song::current_song != nil
				@bgm_playing.stop
				@bgm_playing = @bgm[bgm]
				@bgm_playing.play looping
			else
				@bgm_playing = @bgm[bgm]
				@bgm_playing.play looping
			end
			return true
		else
			return false
		end
	end

	# Play a SE from SE hash.
	# @param [String] se SE name (exactly filename without extension).
	# @param [Integer] volume Volume.
	# @param [Integer] speed Speed.
	# @param [true/false] looping Play in loop.
	def play_se(se, volume = 1, speed = 1, looping = false)
		if @se[se] != nil
			@se[se].play
			return true
		else return false end
	end

	def load_directory(bgm_path, se_path)
		@bgm.clear
		@se.clear
		Dir.foreach(bgm_path).each do |bgm|
			path = "#{bgm_path}/#{bgm}"
			@bgm[bgm.split('.')[0]] = Gosu::Song.new(@handle, path) if File.file? path
		end
		Dir.foreach(se_path).each do |se| @se[se] = Gosu::Sample.new(@handle, se.split('.')[0]) if File.file? se
		end
	end

	def stop_bgm
		@bgm_playing.stop if Gosu::Song::current_song != nil
	end
end
