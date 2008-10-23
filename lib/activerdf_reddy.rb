require 'rubygems'
require 'rena'
require 'active_rdf'

class ReddyAdapter < RDFLite
  attr_reader :namespaces
  ConnectionPool.register_adapter(:reddy, self)
  
  def initialize(params = {})
    super
    @namespaces = {}
  end
  
  def fetch(uri)
    # check if uri starts with http://
    return unless uri.match(/http:\/\/(.*)/)
    
    $activerdflog.debug "fetching from #{uri}"
    
    url = URI.parse(uri)
    found = false 
    until found 
      host, port = url.host, url.port if url.host && url.port 
      req = Net::HTTP::Get.new(url.path, 'Accept' => 'application/rdf+xml') 
      res = Net::HTTP.start(host, port) {|http| http.request(req) }
      res.header['location'] ? url = URI.parse(res.header['location']) : found = true
    end
    parser = Rena::RdfXmlParser.new(res.body, uri)
    triples = parser.graph.triples.map { |t| t.to_ntriples }
    
    # TODO: make this generic
    ns = parser.xml.root.elements[1].namespaces
    @namespaces.merge!(ns)
    
    context = RDFS::Resource.new(uri)
    add_ntriples(triples, context)
  end
end
