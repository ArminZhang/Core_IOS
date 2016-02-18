Pod::Spec.new do |s|
s.name = 'MFCore'
s.version = '0.1.0'
s.license = 'MIT'
s.summary = 'Some commonly used code collection on iOS.'
s.homepage = 'https://github.com/ArminZhang/Core_IOS'
s.authors = { 'armin' => '15717503@qq.com' }
s.source = { :git => 'https://github.com/ArminZhang/Core_IOS.git', :tag => s.version.to_s }
s.requires_arc = true
s.ios.deployment_target = '7.0'
s.source_files = 'core/*.{h,m}'
end
