module Echocat
  class Book < Struct.new(*%i[title isbn authors description])
    include CommonMethods

    def print
      puts "Book: "
      puts "   Title: #{title}"
      puts "   ISBN: #{isbn}"
      puts "   Authors: "
      puts "       #{print_authors}"
      puts "   Description: #{description}"
    end
  end
end
