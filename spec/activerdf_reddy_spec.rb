require 'lib/activerdf_reddy'

describe ReddyAdapter do
  before(:each) do
    @adapter = ReddyAdapter.new
  end
  
  it "should create a new reddy adapter" do
    @adapter.should_not be_nil
  end
end