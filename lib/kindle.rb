require 'nokogiri'
require 'mechanize'
require "kindle/version"

module Kindle

  class Highlight
    attr_reader :highlight, :asin
    def initialize(params={:highlight=>nil, :asin=>nil})
      params.each_pair do |k,v|
        instance_variable_set("@#{k}", v)
      end
    end
  end

  # TODO: module here????

    class HighlightsParser

      include Nokogiri
      
      KINDLE_URL           = 'http://kindle.amazon.com'
      USER_AGENT_ALIAS     = 'Windows IE 7'
      SIGN_IN_TEXT         = 'Sign in'
      YOUR_HIGHLIGHTS_TEXT = 'Your highlights'

      def to_s
        "<Kindle::Kindle: " + instance_variables.collect{|k,v| "#{k} => #{v.inspect}" } * ', ' + '>'
      end

      def inspect; to_s; end

      def default_options
        { 
          :agent              => Mechanize.new,
          :username           => nil,
          :password           => nil,
          :highlights         => [],
          :current_offset     => 25,
          :current_highlights => 1,
          :current_upcoming   => [],
          :current_page       => nil,
        }
      end

      def initialize_options(options)
        options.each_pair do |k,v|
          instance_variable_set("@#{k}", v)
          self.class.class_eval "attr_accessor :#{k}"
        end
      end

      def current_page
        puts @current_page.body
        @current_page
      end

      def initialize_agent
        agent.redirect_ok = true
        agent.user_agent_alias = USER_AGENT_ALIAS
      end

      def initialize(options)
        initialize_options(default_options.merge(options))
        initialize_agent
      end

      def first_page
        @first_page ||= agent.get(KINDLE_URL)
      end

      def sign_in_page
        @sign_in_page ||= first_page.link_with(:text => SIGN_IN_TEXT).click
      end

      def login
        sign_in_page.forms.first.email    = username
        sign_in_page.forms.first.password = password
        current_page = sign_in_page.forms.first.submit
      end

      def fetch_highlights
        asins = []
        current_page = current_page.link_with(:text => YOUR_HIGHLIGHTS_TEXT).click
        extract_highlights(current_page)
        until current_highlights.length == 0 do
          next_highlights
        end
      end

      def extract_highlights(page)
        current_highlights = hls = (page/".yourHighlight")
        asins = (page/".asin").collect{|asin| asin.text}
        if hls.length > 0 
          current_upcoming = (page/".upcoming").first.text.split(',') rescue [] 
          current_offset = ((current_page/".yourHighlightsHeader").collect{|h| h.attributes['id'].value }).first.split('_').last
          (page/".yourHighlight").each do |hl|
            highlight = parse_highlight(hl)
            highlights << highlight
            if !asins.include?(highlight.asin)
              asins << highlight.asin unless asins.include?(highlight.asin)
            end
          end
        end
      end

      def asins_string
        asins.map{|l| "used_asins[]=#{l}" } * '&'
      end

      def current_highlight_url
        "https://kindle.amazon.com/your_highlights/next_book?#{asins_string}&current_offset=#{current_offset}&#{upcoming_string}"
      end

      def next_highlights
        upcoming_string = current_upcoming.map{|l| "upcoming_asins[]=#{l}" } * '&'
        current_offset = current_offset 
        current_page = agent.get(current_highlights_url)
        extract_highlights(current_page)
        current_page
      end

      def parse_highlight(hl)
        highlight = (hl/".highlight").text
        asin      = (hl/".asin").text
        Kindle::Highlight.new(:highlight => highlight, :asin => asin)
      end

      def get_highlights
        login
        fetch_highlights
        return highlights.map(&:highlight)
      end

    end

  # end


end

