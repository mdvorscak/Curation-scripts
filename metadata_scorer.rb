class MetadataScorer
# The following is a list of recommended metadata:
  #
  #   property :title
  #   property :description
  #   property :source_type
  #   property :license
  #   property :catalog_name
  #   property :url
  #   property :documentation_url
  #   property :license_url
  #   property :catalog_url
  #   property :released
  #   property :period_start
  #   property :period_end
  #   property :frequency
  #   property :organization_id
  #
	DEFAULT_METADATA=["title","description","source_type","license",
			"catalog_name","url","documentation_url",
			"license_url","catalog_url","released",
			"period_start","period_end","frequency",
			"organization_id"]

	#The default metadata may be overriden but it must be in a single format	# either all symbols or all strings, it must also appear in the form of 	#an array.
	#+metadata+ is passed in as a hash.	
	def initialize(mode,metadata,required_metadata=DEFAULT_METADATA)
		@logger=Logger.new(mode,"metadata_scorer")
		@metadata=metadata
		@required_metadata=required_metadata
		@score=0
	end

	def score
		@score+=score_by_string()
		@score+=score_by_symbol()
	end

	private

	def score_by_string
		string_score=0
		@required_metadata.each {|data| string_score+=1 if metadata[data]}
		string_score
	end

	def score_by_symbol
		symbol_score=0
		begin
			@required_metadata.each_index do |x|
				symbol_score+=1 if metadata[@required_metadata[x].intern]
			end
		rescue
			@logger.log("Error while symbolizing: "+$!
		end

		symbol_score
	end

