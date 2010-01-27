# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{seamus}
  s.version = "0.2.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Scott Burton"]
  s.date = %q{2010-01-26}
  s.description = %q{Seamus is not an Irish monk. Instead, it inspects a file and returns whatever metadata it can determine.}
  s.email = %q{scottburton11@gmail.com}
  s.extra_rdoc_files = [
    "LICENSE",
     "README.rdoc"
  ]
  s.files = [
    ".document",
     ".gitignore",
     "LICENSE",
     "README.rdoc",
     "Rakefile",
     "VERSION",
     "features/Seamus.feature",
     "features/step_definitions/Seamus_steps.rb",
     "features/support/env.rb",
     "lib/Seamus.rb",
     "lib/core/numeric.rb",
     "lib/mime_table.rb",
     "lib/seamus/inspector.rb",
     "lib/seamus/inspector/application_inspector.rb",
     "lib/seamus/inspector/audio_inspector.rb",
     "lib/seamus/inspector/image_inspector.rb",
     "lib/seamus/inspector/text_inspector.rb",
     "lib/seamus/inspector/video_inspector.rb",
     "lib/seamus/processor.rb",
     "lib/seamus/processor/application_processor.rb",
     "lib/seamus/processor/audio_processor.rb",
     "lib/seamus/processor/image_processor.rb",
     "lib/seamus/processor/text_processor.rb",
     "lib/seamus/processor/video_processor.rb",
     "spec/Seamus_spec.rb",
     "spec/lib/core/numeric_spec.rb",
     "spec/lib/seamus/inspector/image_inspector_spec.rb",
     "spec/lib/seamus/processor/image_processor_spec.rb",
     "spec/spec_helper.rb"
  ]
  s.homepage = %q{http://github.com/scottburton11/Seamus}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{Seamus is not an Irish monk}
  s.test_files = [
    "spec/lib/core/numeric_spec.rb",
     "spec/lib/seamus/inspector/image_inspector_spec.rb",
     "spec/lib/seamus/processor/image_processor_spec.rb",
     "spec/seamus_spec.rb",
     "spec/spec_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
