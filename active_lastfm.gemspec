Gem::Specification.new do |s|
  s.name = %q{active_lastfm}
  s.version = "1.0.0"
  s.date = %q{2008-02-03}
  s.authors = ["Ben Smith"]
  s.email = %q{ben@thesmith.co.uk}
  s.summary = %q{Last.fm client for Ruby (and Rails) based on ActiveResource}
  s.homepage = %q{http://thesmith.co.uk/}
  s.description = %q{Last.fm client for Ruby (and Rails) based on ActiveResource}
  s.files = Dir.glob('lib/*.rb')
  s.add_dependency('activeresource', '>= 2.0.2')
  s.autorequire = 'activeresource'
  s.test_files = ('test/active_lastfm_test.rb')
end

