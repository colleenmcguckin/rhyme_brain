require 'net/http'
require 'json'


# This class uses the Rhymebrain API to fetch rhymes, word info, and portmanteaus.
# https://rhymebrain.com/api.html
class RhymeBrain
  attr_reader :word
  attr_accessor :max_results

  BASE_URI = "https://rhymebrain.com/talk?function=get".freeze

  # Supported Functions
  RHYMES = "Rhymes".freeze
  WORD_INFO = "WordInfo".freeze
  PORTMANTEAUS = "Portmanteaus".freeze

  # @param word [String] The word or phrase to search for.
  # @param max_results [Int] The maximum number of results to resturn.
  def initialize(word, max_results = nil)
    @word = word
    @max_results = max_results
  end

  def rhymes
    get(RHYMES)
  end

  def word_info
    get(WORD_INFO)
  end

  def portmanteaus
    get(PORTMANTEAUS)
  end

  private

  # @param function [String] The api function to call.
  def get(function)
    uri = URI("#{BASE_URI}#{function}&word=#{@word}&maxResults=#{@max_results}")
    response = Net::HTTP.get(uri)
    JSON.parse(response)
  end

end
