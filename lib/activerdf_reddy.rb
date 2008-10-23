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
    Net::HTTP.start(url.host, url.port) do |http|
      response = http.get(url.path, 'Accept' => 'application/rdf+xml')
      parser = Rena::RdfXmlParser.new(response.body, uri)
    end
    triples = parser.graph.triples.map { |t| t.to_ntriples }
    
    # TODO: make this generic
    ns = parser.xml.root.elements[1].namespaces
    @namespaces.merge!(ns)
    
    context = RDFS::Resource.new(uri)
    add_ntriples(triples, context)
  end
end
