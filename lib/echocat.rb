# frozen_string_literal: true

require './lib/echocat/common_methods'
require './lib/echocat/author'
require './lib/echocat/book'
require './lib/echocat/magazine'

module Echocat
  $authors = []
  $books = []
  $magazines = []

  class << self
    def run
      read_data

      # Print out all books and magazines (could be a GUI, console, …) with all their details (with a meaningful output format).
      print_header 'All items:'
      print_objects $books+$magazines


      # Find a book or magazine by its isbn.
      print_header 'Items by isbn (2365-8745-7854):'
      print_objects find_by_isbn($books+$magazines, '2365-8745-7854')


      # Find all books and magazines by their authors’ email.
      print_header 'Items by email (ferdinand@echocat.org):'
      print_objects find_by_author($books+$magazines, 'null-ferdinand@echocat.org')


      # Print out all books and magazines with all their details sorted by title. This sort should be done for books and magazines together.
      print_header 'Items sorted by title:'
      print_objects ($books+$magazines).sort_by(&:title)

      # Filter items by ISBN entered by the user in console
      print_header 'Filter by ISBN:'
      puts 'Enter the ISBN:'
      isbn = gets
      items = find_by_isbn($books+$magazines, isbn.strip)
      items.any? ? print_objects(items) : puts('No Items Found!')

      # Filter items by Author's email entered by the user in console
      print_header 'Filter by Author:'
      puts 'Enter the email:'
      email = gets
      items = find_by_author($books+$magazines, email.strip)
      items.any? ? print_objects(items) : puts('No Items Found!')


      $authors << Author.new('vetian@gmail.com', 'Alin', 'Vetian')
      export_authors

      $books << Book.new('New Book', '1234-1234-1234', 'vetianalin@gmail.com', 'Description')
      export_books

      $magazines << Magazine.new('New Magazine', '1234-1234-1234', 'vetianalin@gmail.com', Date.today.strftime('%d.%m.%Y'))
      export_magazines
    end


    def export_authors
      export_csv($authors, %w[email firstname lastname], './data/exported_authors.csv')
    end

    def export_books
      export_csv($books, %w[title isbn authors description], './data/exported_books.csv')
    end

    def export_magazines
      export_csv($magazines, %w[title isbn authors publishedAt], './data/exported_magazines.csv')
    end

    def export_csv(objects, headers, file_path)
      CSV.open( file_path, 'w', col_sep: ';' ) do |csv|
        csv << headers
        objects.each do |object|
          csv << object.to_a
        end
      end
    end

    private

    def print_header(text)
      puts ''
      puts '------------------------------'
      puts text
      puts '------------------------------'
    end

    def read_data
      $authors = read_csv('./data/authors.csv', Author)
      $books = read_csv('./data/books.csv', Book)
      $magazines = read_csv('./data/magazines.csv', Magazine)
    end

    def read_csv(file_path, structure)
      data = []
      CSV.foreach(file_path, headers: false, encoding: 'ISO-8859-1', col_sep: ';') do |row|
        next if $. == 1
        data << structure.new(*row)
      end
      data
    end

    def print_objects(objects)
      objects.each do |object|
        object.print
      end
    end

    def find_by_isbn(objects, isbn)
      objects.select { |a| a.isbn == isbn.to_s }
    end

    def find_by_author(objects, email)
      email = "null-#{email}" unless email.start_with?('null-')
      objects.select { |a| a.authors.split(',').include?(email) }
    end
  end
end







