module Echocat
  class Author < Struct.new(*%i[email first_name last_name])

    def print
      puts "      #{first_name} #{last_name} - #{email.gsub('null-', '')}"
    end

    def to_a
      [email, first_name, last_name]
    end
  end
end
