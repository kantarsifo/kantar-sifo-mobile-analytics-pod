Pod::Spec.new do |s|
  s.name                = 'TSMobileAnalytics'
  s.version             = '5.0.3'

  s.summary             = 'TSMobileAnalytics'
  s.homepage            = 'http://kantarsifo.se'

  s.license             = { :type => 'Commercial', :file => 'LICENSE' }
  s.author              = { 'Kantar Sifo' => 'info@tns-sifo.se' }
  s.source              = { :git => 'https://github.com/kantarsifo/kantar-sifo-mobile-analytics-pod.git', :tag => s.version }

  s.preserve_paths      = 'Documentation/**/*', 'Samples/**/*'

  s.platform            = :ios, '9.0'
  s.vendored_frameworks = 'TSMobileAnalytics.framework'

  s.frameworks          = 'Foundation', 'UIKit', 'Security'
  s.module_name         = 'TSMobileAnalytics'
end
