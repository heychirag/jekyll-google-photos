lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "jekyll-google-photos/version"
Gem::Specification.new do |spec|
  spec.name          = "jekyll-google-photos"
  spec.summary       = "Embedd Google Photos Album to your Jekyll Site"
  spec.description   = "Embedd Google Photos Album to your Jekyll Site"
  spec.version       = JekyllGooglePhotos::VERSION
  spec.authors       = ["Chirag Arora"]
  spec.email         = ["me@chia.ro"]
  spec.homepage      = "https://github.com/heychirag/jekyll-google-photos"
  spec.licenses      = ["MIT"]
  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r!^(test|spec|features)/!)  }
  spec.require_paths = ["lib"]
  spec.add_dependency "jekyll", "~> 3.0"
  spec.add_development_dependency "rake", "~> 11.0"
  spec.add_development_dependency "rspec", "~> 3.5"
  spec.add_development_dependency "rubocop", "~> 0.52"
  spec.add_development_dependency "nokogiri", "~> 1.10"
end
