# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "text-invoice/version"

Gem::Specification.new do |s|
  s.name        = "text-invoice"
  s.version     = TextInvoice::VERSION
  s.authors     = ["tarn"]
  s.email       = ["tarn.barford@gmail.com"]
  s.homepage    = ""
  s.summary     = "invoicing tools"
  s.description = ""

  s.rubyforge_project = "text-invoice"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency "rspec"
  s.add_dependency "mustache"
end
