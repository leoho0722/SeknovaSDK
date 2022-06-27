Pod::Spec.new do |s|
  s.name             = 'SeknovaSDK'
  
  s.version          = '0.0.17.1'
  
  s.summary          = 'SDK Test'

  s.description      = 'Seknova SDK Test'

  s.homepage         = 'https://github.com/leoho0722/SeknovaSDK'
  
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  
  s.author           = { 'leoho0722' => 'leo160918@gmail.com' }
  
  s.source           = { :git => 'https://github.com/leoho0722/SeknovaSDK.git', :tag => s.version.to_s }

  s.ios.deployment_target = '13.0'

  s.swift_version = '5.5.1'
  
  s.source_files = 'SeknovaSDK/Classes/**/*'

  s.frameworks = 'UIKit', 'Foundation', 'CoreBluetooth'
  
  s.dependency 'AWSCore', '2.26.3'
  s.dependency 'AWSCognitoIdentityProvider', '2.26.3'
  s.dependency 'AWSCognitoIdentityProviderASF', '2.26.3'
  s.dependency 'AWSS3', '2.26.3'
  s.dependency 'AWSUserPoolsSignIn', '2.26.3'
  s.dependency 'AWSMobileClient', '2.26.3'
  s.dependency 'AWSAuthCore', '2.26.3'
  s.dependency 'AWSAuthUI', '2.26.3'
  s.dependency 'RealmSwift', '10.20.0'
  s.dependency 'CryptoSwift', '1.0.0'
end
