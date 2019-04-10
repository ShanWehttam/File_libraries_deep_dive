#!/usr/bin/env ruby

require "fileutils"

class DoWeNeedFileLibraries

  def any_instance_methods?(clas)
    clas.instance_methods(false).empty?
  end

  def filetest?
    any_instance_methods?(FileTest)
    if FileTest.methods(false).count.eql?((FileTest.methods(false) & File.methods(false)).count)
      "We do not need FileTest class!"
    else
      "filetest: NEEDED"
    end
  end

  def file_stat?
    File::Stat.instance_methods(false).count #=> 43
    File::Stat.methods(false).count #=> 0
    File.methods(false).count #=> 58
    (File::Stat.instance_methods(false) & File.methods(false)).count #=> 28
    unless (File::Stat.instance_methods(false) - File.methods(false)).empty? #=> 15 unique methods for File::Stat
      puts "file_stat is needed.  Here are the 15 unique methods:"
      (File::Stat.instance_methods(false) - File.methods(false)).count
    end
  end

  def fileutils?
    FileUtils.methods(false).count #=> 50
    FileUtils.instance_methods(false).count #=> 0
    (FileUtils.methods(false) - File.methods(false)).count
    unless (FileUtils.methods(false) - File.methods(false)).empty? #=> 45 unique methods for File::Stat
      puts "file_utils is needed.  Here are the 45 unique methods:"
      (FileUtils.methods(false) - File.methods(false)).count
    end
  end

end

puts DoWeNeedFileLibraries.new.filetest?
puts DoWeNeedFileLibraries.new.file_stat?
puts DoWeNeedFileLibraries.new.fileutils?
