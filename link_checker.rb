require 'net/http'
require 'uri'
class LinkChecker
	def response_code(uri_string)
		uri=URI.parse(uri_string)
		Net::HTTP.start(uri.host,uri.port){|http| 
			response= http.head(uri.path.size > 0 ? uri.path : "/")
			response.code.to_i
		}
	end

	#Could add all error code in the future if they are needed
	def translate_code(code)
		type=code/100
		case type
		when 1
			return "Information"
		when 2
			return "Success"
		when 3
			return "Redirection"
		when 4
			return "Client Error"
		when 5
			return "Server Error"
		else
			return "Unknown Error"
		end
	end

	def good_link?(url)
		return response_code(url)==200
	end
end
