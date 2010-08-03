require 'net/http'
require 'uri'
require File.dirname(__FILE__)+ '/logger'
class LinkChecker

	def initialize(mode = "production")
		@log = Logger.new(mode, "link_checker")
	end

	def response_code(uri_string)
		#Without http:// at the beginning of the url, all requests fail.
		#Make sure to add it if it isn't in there.
		http_match = uri_string.match(/^http:\/\//)
		uri_string = "http://"+uri_string unless http_match

		
		uri = URI.parse(uri_string)
		begin
		Net::HTTP.start(uri.host, uri.port) do |http| 
			response = http.head(uri.path.size > 0 ? uri.path : "/")
			@rc = response.code.to_i
			@log.log(uri_string+" yeilded "+@rc.to_s+" "+
				    translate_code(@rc))
			@rc
    end
		rescue
			@log.log("Invalid url entered: "+uri_string)
      nil
		end
	end

	#Could add all error code in the future if they are needed
	def translate_code(code)
		type=code/100
		case type
		when 1 : "Information"
		when 2 : "Success"
		when 3 : "Redirection"
		when 4 : "Client Error"
		when 5 : "Server Error"
		else
      "Unknown Error"
		end
	end

	def good_link?(url)
		response_code(url) == 200
	end

  def full_response(url)
    response_code(url)
    @rc.to_s+": "+translate_code(@rc)
  end
end
