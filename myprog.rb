#!/usr/bin/env ruby
require 'date' 

#str = (STDIN.tty?) ? 'not reading from stdin' : $stdin.read

str = "@p1 asdf ads ds #3 task1, task 2 fads ds a dfa  dsf a
@p2 #1 task4, task 5
fas @p3 to #1 fasdfla sf
fasfadsfa"

regex_entries = /@([a-zA-Z0-9]+).*#(\d+\.?\d*)(.*)/
str.scan(regex_entries) { |r|
	puts r[0]
	puts r[1]
	puts r[2].strip

}