class SimplyHiredSearch
  require 'open-uri'
  require 'nokogiri'
  require 'ostruct'

  API_TEMPLATE = "http://api.simplyhired.com/a/jobs-api/xml-v2/q-SEARCH_TERM?pshid=41106&ssty=2&cflg=r&jbd=joblander.jobamatic.com&clip=74.94.200.198"

  def self.search(term)
    doc = Nokogiri::XML(open(API_TEMPLATE.sub('SEARCH_TERM', term)))
    positions = doc.xpath('//r').collect do |node|

      position = OpenStruct.new
      position.title = node.xpath("jt").text
      position.url = node.xpath("src/@url").text
      position.source  = node.xpath("src").text
      position.city  = node.xpath("loc/@cty").text
      position.state  = node.xpath("loc/@st").text
      position.country  = node.xpath("loc/@country").text
      position.description = node.xpath("e").text
      position.post_date = node.xpath("dp").text
      position.job_type = node.xpath("ty").text
      position
    end
  end
end