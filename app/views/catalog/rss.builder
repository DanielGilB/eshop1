xml.instruct! # :xml, :version=>"1.0", :encoding=>"UTF-8"

xml.rss("version" => "2.0", "xmlns:dc" => "http://purl.org/dc/elements/1.1/") do
  xml.channel do
    xml.title @page_title
    xml.link(url_for(:action => "index", :only_path => false))
    xml.language "es-es"
    xml.ttl "40"
    xml.description "INE's Music: Música por y para la gente."

    for disc in @discs
      xml.item do
        xml.title(disc.title)
        xml.description("#{disc.title} by #{disc.artist_names}")
        xml.pubDate(disc.created_at.to_s(:long))
        xml.guid(url_for(:action => "show", :id => disc, :only_path => false))
        xml.link(url_for(:action => "show", :id => disc, :only_path => false))
      end
    end
  end
end
