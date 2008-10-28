require 'lib/activerdf_reddy'

describe ReddyAdapter do
  before(:each) do
    @adapter = ReddyAdapter.new
  end
  
  it "should create a new reddy adapter" do
    @adapter.should_not be_nil
  end
  
  describe 'fetching Programmes Ontology' do
    before(:each) do
      @adapter.fetch('http://purl.org/ontology/po/')
    end
  
    it "should have added some triples" do
      @adapter.should have_at_least(1).items
    end
  end
  
  # Reddy doesn't support DBPedia RDF yet
  describe 'fetching DBPedia Resource' do
    # before(:each) do
    #   @adapter.fetch('http://dbpedia.org/resource/Geogaddi')
    # end

    it "should have added some triples" # do
    #       @adapter.should have_at_least(1).items
    #     end
  end

  # Reddy doesn't support music ontology rdf yet
  describe 'fetching Music Ontology' do
    # before(:each) do
    #   @adapter.fetch('http://purl.org/ontology/mo/')
    # end

    it "should have added some triples" # do
     #      @adapter.should have_at_least(1).items
     #    end                                
  end
end
