class PositionFactory
  def self.build_from_search_results(struct)
    Position.new do |position|
      position.name = struct.title
      position.app_link = struct.url
      position.source  = struct.source
      position.company = struct.source
      position.city  = struct.city
      position.state  = struct.state
      position.country  = struct.country
      position.details = struct.description
      position.post_date = Time.parse(struct.post_date) if struct.post_date
      position.pstatus = 'to_review'
    end
  end
end