module Echocat
  class Magazine < Struct.new(*%i[title isbn authors published_at])
    include CommonMethods

    def print
      puts "Magazine: "
      puts "   Title: #{title}"
      puts "   ISBN: #{isbn}"
      puts "   Published At: #{published_at}"
      puts "   Authors: "
      puts "       #{print_authors}"
    end
  end
end
