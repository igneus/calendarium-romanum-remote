require_relative 'lib/calendarium-romanum/remote/version'

Gem::Specification.new do |s|
  s.name        = 'calendarium-romanum-remote'
  s.version     = CalendariumRomanum::Remote::VERSION
  s.date        = '0000-01-01'
  s.summary     = 'remote calendar extension for calendarium-romanum'

  s.description = 'obtains calendar data from an API'

  s.authors     = ['Jakub Pavlík']
  s.email       = 'jkb.pavlik@gmail.com'
  s.files       = %w(lib/**/*.rb spec/*.rb)
                  .collect {|glob| Dir[glob] }
                  .flatten
                  .reject {|path| path.end_with? '~' } # Emacs backups
  s.homepage    = 'http://github.com/igneus/calendarium-romanum-remote'
  s.licenses    = ['LGPL-3.0', 'MIT']

  s.add_dependency 'calendarium-romanum', '0.3.0'
  s.add_development_dependency 'rake', '~> 12.0'
  s.add_development_dependency 'rspec', '~> 3.6'
end
