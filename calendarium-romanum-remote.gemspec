require_relative 'lib/calendarium-romanum/remote/version'

Gem::Specification.new do |s|
  s.name        = 'calendarium-romanum-remote'
  s.version     = CalendariumRomanum::Remote::VERSION
  s.date        = CalendariumRomanum::Remote::RELEASE_DATE.to_s
  s.summary     = 'remote calendar extension for calendarium-romanum'

  s.description = 'obtains calendar data from an API'

  s.authors     = ['Jakub Pavlík']
  s.email       = 'jkb.pavlik@gmail.com'
  s.files       = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  s.homepage    = 'http://github.com/igneus/calendarium-romanum-remote'
  s.licenses    = ['LGPL-3.0', 'MIT']

  s.add_dependency 'calendarium-romanum', '~> 0.4'
  s.add_dependency 'httpi', '~> 2.0'
  s.add_dependency 'multi_json', '~> 1.13'
  s.add_dependency 'dry-schema', '~> 1.3'
  s.add_development_dependency 'rake', '~> 12.0'
  s.add_development_dependency 'rspec', '~> 3.6'
end
