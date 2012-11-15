#!/usr/bin/env ruby
require 'mkmf'

#create_makefile("ffi_c")

File.open('Makefile', 'wb') do |mf|
  mf.puts "# One day I'll grow up to be a real Makefile created by mkmf"
  mf.puts "all install::"
end
