Gem::Specification.new do |s|
  s.name = "activerdf_reddy"
  s.version = "0.0.1"
  s.date = "2008-10-22"
  s.summary = "ActiveRDF RDFLite Reddy adapter"
  s.email = "metade@gmail.com"
  s.homepage = "http://github.com/metade/activerdf_reddy"
  s.description = "An ActiveRDF RDFLite adapter based on Reddy, a Ruby RDF library"
  s.has_rdoc = true
  s.authors = ['Patrick Sinclair']
  s.files = ["README", "Rakefile", "activerdf_reddy.gemspec", "lib/activerdf_reddy.rb"]  
  s.test_files = ["spec/activerdf_reddy_spec.rb"]
  #s.rdoc_options = ["--main", "README.txt"]
  #s.extra_rdoc_files = ["History.txt", "Manifest.txt", "README.txt"]
  s.add_dependency("reddy")
  s.add_dependency("activerdf")  
  s.add_dependency("activerdf_rdflite")  
end