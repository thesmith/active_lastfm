Gem::Specification.new do |s|
  s.name = %q{active_lastfm}
  s.version = "1.0.1"
  s.date = %q{2008-10-12}
  s.authors = ["Ben Smith"]
  s.email = %q{ben [at] thesmith [dot] co [dot] uk}
  s.has_rdoc = true
  s.rdoc_options = ["--main", "README"]
  s.extra_rdoc_files = ["README"]
  s.summary = %q{Last.fm client for Ruby (and Rails) based on ActiveResource}
  s.homepage = %q{http://github.com/thesmith/active_lastfm}
  s.description = %q{Last.fm client for Ruby (and Rails) based on ActiveResource}
  s.files = ["README", "active_lastfm.gemspec", "lib/active_lastfm.rb", "lib/patch.rb"]
  s.add_dependency('activeresource', '>= 2.0.2')
  s.test_files = ('test/active_lastfm_test.rb')
end

