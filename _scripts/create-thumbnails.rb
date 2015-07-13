#!/usr/bin/env ruby

require 'rmagick'
require 'fileutils'
include Magick

ARGV.empty? && raise('Usage: PROG <dir>')
dir = File.expand_path(ARGV.shift)

height = 750
width = 500
preview_dir = File.join(dir, "#{height}x#{width}")

FileUtils::mkdir_p(preview_dir)
files = Dir.glob("#{dir}/*.jpg").each { |file|
    img = ImageList.new(file)
    img.resize_to_fill!(height, width)
    basename = File.basename(file)
    img.write(File.join(preview_dir, basename))
}
