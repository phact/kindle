require 'nokogiri'
require 'mechanize'
require_relative 'kindle/highlight'
require_relative 'kindle/highlights_parser'
require 'cql'

module Kindle

  class Highlights

    def initialize(options = {})
      options.each { |k,v| instance_variable_set("@#{k}", v) }
    end

    def fetch_highlights
      parser = HighlightsParser.new(login: @login, password: @password)
      parser.get_highlights
    end

  end

end
