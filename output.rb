require 'fileutils.rb'
class Output

  def self.file(path)
    file = absolute_path(path)
    FileUtils.mkdir_p(File.dirname(file))
    file
  end

  def self.absolute_path(path)
    File.expand_path(File.join(File.dirname(__FILE__), path))
  end

end
