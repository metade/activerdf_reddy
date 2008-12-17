require 'rubygems'
require 'active_rdf'
require 'reddy'

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
      path = url.query.nil? ? url.path : "#{url.path}?#{url.query}"
      req = Net::HTTP::Get.new(path, 'Accept' => 'application/rdf+xml') 
      res = Net::HTTP.start(host, port) {|http| http.request(req) }
      res.header['location'] ? url = URI.parse(res.header['location']) : found = true
    end
    
    # TODO: make this generic
    parser = Reddy::RdfXmlParser.new(res.body, uri)
    triples = parser.graph.triples.map { |t| t.to_ntriples }
    parser.xml.root.namespace.each { |n| @namespaces[n.prefix] = n.href }
    
    context = RDFS::Resource.new(uri)
    add_ntriples(triples, context)
  end
end
