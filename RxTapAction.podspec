#
# Be sure to run `pod lib lint RxTapAction.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'RxTapAction'
  s.version          = '0.1.0'
  s.summary          = 'ReactiveExtensions for adding tap action gesture.'

  s.description      = <<-DESC
ReactiveExtensions for adding tap action gesture to UIView or UICollectionView.
                       DESC

  s.homepage         = 'https://github.com/lm2343635/RxTapAction'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'lm2343635' => 'lm2343635@126.com' }
  s.source           = { :git => 'https://github.com/lm2343635/RxTapAction.git', :tag => s.version.to_s }

  s.requires_arc     = true
  s.swift_version    = '5.0'

  s.source_files     = 'RxTapAction/Classes/**/*'
  
  s.dependency 'RxSwift'
  s.dependency 'RxCocoa'
  s.dependency 'RxGesture'

  s.ios.deployment_target = '9.0'
end
