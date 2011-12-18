require 'kindle'
require 'rspec'

describe Kindle::Highlight do


  def highlight_params(params)
    {:asin => '123', }.merge(params)
  end

  describe "Happy path" do

    before(:all) do
      @highlight = Kindle::Highlight.new
    end

    it "should be generally okay" do
      @highlight.should_not be_nil
    end
    
    it "should contain an ASIN" do
      @highlight.should respond_to :asin
    end

  end

end
