url = 'http://api.simplyhired.com/a/jobs-api/xml-v2/q-engineer?pshid=41106&ssty=2&cflg=r&jbd=joblander.jobamatic.com&clip=74.94.200.198'
require 'open-uri'
doc = Nokogiri::XML(open(url))

list = doc.xpath('//r').collect do |node|
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

#TODO: read/unread flag on positions

<r>
<jt>
Combat Engineer - Construction and Engineering Specialist
</jt>
<cn url="">Army National Guard</cn>
<src url="http://api.simplyhired.com/a/job-details/view/cparm-cF9pZD00MTEwNiZ6b25lPTYmaXA9JmNvdW50PTUwJnN0YW1wPTIwMTItMDMtMDYgMTg6Mzc6NDQmcHVibGlzaGVyX2NoYW5uZWxfaWRzPSZhX2lkPTE3MjgxJmNfaWQ9MTUzMjgmY3BjPTIuNTEmcG9zPTEmaGFzaD05MGM1NzgxMzRkZjNiNTI1OWNjMTRmYTkxZDlkMjJhYg%3D%3D%3B962f682fcc4fa914807afdb7bba7ac81/jobkey-26823a71bfc7a53f4dd585858505b4a473647e9/pub_id-41106/cjp-0">Army National Guard</src>
<ty>sponsored</ty>
<loc cty="Edinburgh" st="IN" postal="46124" county="" region="" country="US">Edinburgh, IN</loc>
<ls>2012-03-01T23:23:45Z</ls>
<dp>2012-03-01T23:23:45Z</dp>
<e>
We're looking for team players to provide construction and engineering support vital to the successful outcome of Army ... including construction, building inspection, and building engineering. Earn while you learn Get paid to learn! Join...
</e>
</r>