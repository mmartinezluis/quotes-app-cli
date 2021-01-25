require_relative "../lib/collaborating_quote_class.rb"
require_relative "../lib/scraper.rb"
require_relative "../lib/author.rb"
require_relative "../lib/category.rb"

class QuotesCLI
#  def load_and_create_quotes
#    loaded_quotes = Scraper.random_quote
#    Quote.new(loaded_quotes)
#  end
  def load_and_create_authors
    authors_array = Scraper.random_authors
    Author.create_from_list(categories_array)
  end

  def load_and_create_collaborating_quotes
    loaded_quotes = Scraper.random_quote
    CollaboratingQuote.new(loaded_quotes)
  end

  def load_and_create_categories
    categories_array = Scraper.categories_list
    Category.create_from_list(categories_array)
  end

  def main_menu
    puts "How would you like your quote?"
    puts "  1. Random Quote"
    puts "  2. Quote from category"
    puts "  3. Quote from random authors list"
    puts "\nType the number for your desired option."
  end

  def user_input_method
    input = gets.strip.to_i
    if input < 1 || input > 3
      puts "Please type 1, 2 or 3"
      user_input
    end
    input
  end

  def option1_method
    puts "Retrieving quote ..."
    CollaboratingQuote.random
    puts "\n\nTo return to the main menu enter 1; to get another random quote enter 2; to end the session press any other key."
    end_method_input = gets.to_i
    if end_method_input == 1
      self.call
    elsif end_method_input == 2
      option1_method
    end
  end

  def option2_method
    load_and_create_categories
    puts "Categories:"
    Category.list
    puts "\nType the number for your desired category"
    option2_helper_method_input
    category_input = option2_helper_method_input          # Make the variable "category_input" equal to the return value from the "option2_helper_method_input"
    puts "Retrieving quote ...\n"
    Category.quote_from_category(category_input)
    puts "\n\nTo return to the main menu enter 1; to get another random quote enter 2; to end the session press any other key."
    end_method_input = gets.to_i
    if end_method_input == 1
      self.call
    elsif end_method_input == 2
      Category.quote_from_category(category_input)
    end
  end

  def option3_helper_method_input
    load_and_create_authors
    puts "Authors:"
    Author.list
    puts "\nType the number for your desired author"
    option3_helper_method_input
    author_input = option3_helper_method_input
    puts "Retrieveing quote ..."
    Author.quote_from_author(author_input)
    puts "\n\nTo return to the main menu enter 1; to get another random quote enter 2; to end the session press any other key."
    end_method_input = gets.to_i
    if end_method_input == 1
      self.call
    elsif end_method_input == 2
      Author.quote_from_author(author_input)
    end
  end

  def option2_helper_method_input
    category_input = gets.strip.to_i
    if category_input <= 0 || category_input > Category.all.count
      puts "Invalid input. Please type the number for your desired category"
      option2_helper_method_input
    end
    category_input
  end

  def option3_helper_method_input
    author_input = gets.strip.to_i
    if author_input <= 0 || author_input > 10
      puts "Invalid input. Please type the number for your desired author"
      option3_helper_method_input
    end
    author_input
  end

  def call
    main_menu
    input = user_input_method
    case input
    when 1
      option1_method
    when 2
      option2_method
    when 3
      option3_method
    end
    puts "Closing..."
  end
end


#  def option2_helper_method_load_categories
#    Scraper.categories_list
#    categories_array = Scraper.categories_list
#    Category.create_from_list(categories_array)
#  end