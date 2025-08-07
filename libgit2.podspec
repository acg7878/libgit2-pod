Pod::Spec.new do |s|
  s.name             = 'libgit2'
  s.version          = '1.9.2'
  s.summary          = 'A portable, pure C implementation of the Git core methods.'
  s.homepage         = 'https://libgit2.org/'
  s.license          = { :type => 'GPLv2 with linking exception', :file => 'COPYING' }
  s.author           = { 'The libgit2 contributors' => '' }
  s.source           = { :http => 'file://' + __dir__ + '/libgit2.xcframework.zip' } # Placeholder for local testing

  s.ios.deployment_target = '16.0'
  s.vendored_frameworks = 'libgit2.xcframework'
  s.source_files = 'libgit2/include/git2.h'
  s.requires_arc = false

  s.frameworks = 'Security'
  s.libraries = 'z', 'iconv'

  s.pod_target_xcconfig = { 'CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES' => 'YES' }
end