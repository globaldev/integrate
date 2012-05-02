Gem::Specification.new do |s|
  s.name              = "integrate"
  s.version           = "0.0.1"
  s.rubyforge_project = "integrate"

  s.summary           = "An integration framework for Ruby."
  s.description       = "Integrate is a Ruby framework supporting Enterprise Integration Patterns."

  s.authors           = ["Rob Young", "Mat Sadler", "Andrew Garner"]
  s.email             = ["ryoung@globalpersonals.co.uk", "msadler@globalpersonals.co.uk", "agarner@globalpersonals.co.uk"]
  s.homepage          = "http://github.com/globaldev/integrate"

  s.require_paths     = %w[lib]

  s.rdoc_options      = ["--charset=UTF-8"]
  s.extra_rdoc_files  = %w[README.md LICENSE.md]

  s.files             = %w[README.md LICENSE.md] + Dir["lib/**/*.rb"]
  s.test_files        = Dir["test/**/*.rb"]

  s.add_development_dependency "rake"
  s.add_development_dependency "simplecov"
end
