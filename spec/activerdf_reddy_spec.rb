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
    
    it "should have set the namespaces" do
      @adapter.namespaces['rdf'].should == 'http://www.w3.org/1999/02/22-rdf-syntax-ns#'
      @adapter.namespaces['rdfs'].should == 'http://www.w3.org/2000/01/rdf-schema#'
      @adapter.namespaces['dc'].should == 'http://purl.org/dc/elements/1.1/'
    end
  end
end
