# -*- coding: utf-8 -*-
require 'csv'
require 'digest/sha1'

# Options
# :skip_header_files -- skip headers from filename.
# :uniq -- uniq csv lines.
class CsvCombine
  def self.open(*args)
    files = []
    opt = {}
    args.each do |arg|
      if arg.class == Hash
        opt = arg
      else
        files << arg
      end
    end
    Reader.new(files,opt)
  end
end

class Reader
  include Enumerable
  def initialize(files,opt)
    @files = files
    @opt = opt
  end

  def each
    hash_list = []
    @files.each do |file|
      reader = CSV.open(file,"r")
      reader.shift if @opt[:skip_header_files].class == Array && @opt[:skip_header_files].index(file)
      reader.shift if @opt[:skip_header_files] == file
      reader.each do |row|
        if @opt[:uniq]
          hash = Digest::SHA1.new.update(row.to_s).to_s
          yield row unless hash_list.index(hash)
          hash_list << hash
        else
          yield row
        end
      end
    end
  end
end

