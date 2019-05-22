#
# Be sure to run `pod lib lint RxTapAction.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'RxTapAction'
  s.version          = '0.1.1'
  s.summary          = 'Reactive extensions for adding tap action gesture.'

  s.description      = <<-DESC
Reactive extensions for adding tap action gesture to UIView or UICollectionView.
                       DESC

  s.homepage         = 'https://github.com/RxSwiftCommunity/RxTapAction'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'lm2343635' => 'lm2343635@126.com' }
  s.source           = { :git => 'https://github.com/RxSwiftCommunity/RxTapAction.git', :tag => s.version.to_s }

  s.requires_arc     = true

  s.source_files     = 'RxTapAction/Classes/**/*'
  
  s.dependency 'RxSwift', '~> 5'
  s.dependency 'RxCocoa', '~> 5'
  s.dependency 'RxGesture', '~> 3'

  s.ios.deployment_target = '9.0'
end
