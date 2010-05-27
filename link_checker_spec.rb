require 'link_checker'

describe LinkChecker, "#response_code" do
	before(:all) do
		@lc=LinkChecker.new("test")
	end

	it "should return 200 on a valid link" do
		response=@lc.response_code("http://www.google.com")
		response.should==200
	end

	it "should return 200 on a link without http:// preceding it" do
		response=@lc.response_code("www.google.com")
		response.should==200
	end

end

describe LinkChecker, "#good_link?" do
	before(:all) do
		@lc=LinkChecker.new("test")
	end

	it "should return true when the link works" do
		@lc.good_link?("http://governor.utah.gov/dea/ERG/ERG2008/Selected%20Age.xls").should==true
		@lc.good_link?("governor.utah.gov/dea/ERG/ERG2008/Selected%20Age.xls").should==true
	end

	it "should return false when a link is bad" do
		@lc.good_link?("http://governor.utah.gov/dea/ERG/E008/Selected%20Age.xls").should==false
	end

	it "should return false when link doesn't exist" do
		@lc.good_link?("www.haasddasdhsdaiuywad.com").should==false
	end
end
