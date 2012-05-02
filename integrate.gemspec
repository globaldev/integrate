# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name        = "integrate"
  s.version     = "0.0.1"
  s.authors     = ["Rob Young"]
  s.email       = ["robyoung26@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{TODO: Write a gem summary}
  s.description = %q{TODO: Write a gem description}

  s.rubyforge_project = "integrate"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency "rake"
  s.add_development_dependency "simplecov"
end
