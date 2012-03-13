class SimplyHiredSearch
  require 'open-uri'
  require 'nokogiri'

  API_TEMPLATE = "http://api.simplyhired.com/a/jobs-api/xml-v2/q-SEARCH_TERM?pshid=41106&ssty=2&cflg=r&jbd=joblander.jobamatic.com&clip=74.94.200.198"

  def self.search(term)
    doc = Nokogiri::XML(open(API_TEMPLATE.sub('SEARCH_TERM', term)))
    positions = doc.xpath('//r').collect do |node|
      attrs = {}
      attrs[:title] = node.xpath("jt").text
      attrs[:url]  = node.xpath("src/@url").text
      attrs[:source]  = node.xpath("src").text
      attrs[:city]  = node.xpath("loc/@cty").text
      attrs[:state]  = node.xpath("loc/@st").text
      attrs[:country]  = node.xpath("loc/@country").text
      attrs[:description] = node.xpath("e").text
      attrs[:post_date] = node.xpath("dp").text
      attrs[:job_type] = node.xpath("ty").text
      attrs
    end
  end
end