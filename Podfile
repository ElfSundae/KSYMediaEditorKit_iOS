# Uncomment the next line to define a global platform for your project
platform :ios, '8.0'
#use_frameworks!

dev_path=ENV['KSYLIVEDEMO_DIR']

workspace 'demo.xcworkspace'

############## common dependence libs source ###############

target 'demo' do
    project 'demo.xcodeproj'
    pod 'Bugly'
    pod 'Masonry', '~> 1.1.0'
    pod 'Ks3SDK', '~> 1.7.2'
    pod 'YYKit'
    pod 'MBProgressHUD'
    pod 'HMSegmentedControl'
    pod 'ICGVideoTrimmer'
    pod 'KSYAudioPlotView'
    pod 'ZipArchive'

    pod 'libksygpulive/libksygpulive_265', :path=> dev_path
    
    pod 'KMCSTFilter'
    pod 'CTAssetsPickerController',  '~> 3.3.0'
    pod 'KMCVStab'
    pod 'FDFullscreenPopGesture', '1.1'
    # pod 'TZImagePickerController'
    pod 'SMPageControl'
end
