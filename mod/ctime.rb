# encoding: utf-8

# This module have some shortcuts to use based in milliseconds. If you want to represent 2 minutes, can use: 2 * CTime::MIN.
module CTime
	# Second
	SEC = 1000 unless defined? SEC
	# Minute
	MIN = 60000 unless defined? MIN
	# Hour
	HOU = 3600000 unless defined? HOU
end
