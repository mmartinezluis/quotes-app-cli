# require "pry"
# require 'nokogiri'
# require 'open-uri'
#require_relative '../lib/collaborating_quote_class.rb'

class QuotesApp::Scraper                  #Scraper

  def self.random_quote
    # Working quotes page without dynamic ads
    random_quote_page = Nokogiri::HTML(open("https://blog.hubspot.com/sales/famous-quotes"))
    all_quotes = [ ]
    random_quote_page.css("#hs_cos_wrapper_post_body p").each do |i|
      all_quotes << {:body => i.text.split("\"")[1], :author => i.css("em").text.strip}
    end
    filtered_quotes = all_quotes.delete_if {|i| i.values.include? (nil)}.uniq                 # Array contains a total of 100 qoutes
  end

  def self.categories_list
    categories_list_page = Nokogiri::HTML(open("https://www.brainyquote.com/"))
    all_categories = [ ]
    categories_list_page.css(".homeGridBox #allTopics .bqLn").each do |i|
      all_categories << {:name => i.text, :link => "https://www.brainyquotes.com#{i.css("a").attribute("href").value}"}           # Webpage contains a total of 10 categories
    end
    selected_categories = all_categories.select {|hash| hash[:name] == "Attitude" || hash[:name] == "Life" || hash[:name] == "Motivational" || hash[:name] == "Wisdom" || hash[:name] == "Inspirational"}
  end

  def self.category_quote(category_link)
    #category_quote_page = Nokogiri::HTML(open("https://www.brainyquote.com/topics/love-quotes"))
    category_quote_page = Nokogiri::HTML(open(category_link))
    category_quotes = [ ]
    category_quote_page.css("#quotesList .m-brick").each do |i|
      category_quotes << {:body => i.css("a.b-qt").text, :author => i.css("a.bq-aut").text}                 # Each category webpage contains a total of 60 quotes
   end
   category_quotes.sample
  end

  def self.random_authors
    random_authors_page = Nokogiri::HTML(open("https://www.brainyquote.com/authors"))
    all_authors = [ ]
    random_authors_page.css(".container .bqLn").each do |i|
      all_authors << {:name => i.text.gsub("\n",""), :link => "https://www.brainyquote.com#{i.css("a").attribute("href").value}"}
    end
    all_authors                                                 # The webpage contains a total of 448 authors
  end

  def self.author_quote(author_link)
    #author_quote_page = Nokogiri::HTML(open("https://www.brainyquote.com//authors/martin-luther-king-jr-quotes"))
    author_quote_page = Nokogiri::HTML(open(author_link))
    author_quotes = [ ]
    author_quote_page.css(".reflow_body .m-brick").each do |i|
      author_quotes << {:body => i.css("a.b-qt").text, :author => i.css("a.bq-aut").text}               # The webpage for each author contains 60 quotes
   end
   author_quotes.sample

  end
end
#Scraper.categories_list
