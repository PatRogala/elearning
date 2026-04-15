#!/usr/bin/env ruby

require "localhost"

Localhost::Authority.fetch("localhost")
puts "✓ Certificate generated: ~/.local/state/localhost.rb/localhost.crt"
