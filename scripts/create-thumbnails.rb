#!/usr/bin/env ruby

require 'rmagick'
require 'fileutils'
include Magick

ARGV.empty? && raise('Usage: PROG <dir>')
dir = File.expand_path(ARGV.shift)

width = 600
height = 470
preview_dir = File.join(dir, "#{width}x#{height}")

FileUtils::mkdir_p(preview_dir)
files = Dir.glob("#{dir}/*.jpg").each { |file|
    img = ImageList.new(file)
    img.resize_to_fit!(width, height)
    basename = File.basename(file)
    img.write(File.join(preview_dir, basename))
}
