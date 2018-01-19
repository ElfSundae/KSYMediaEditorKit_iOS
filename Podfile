# Uncomment the next line to define a global platform for your project
platform :ios, '8.0'
#use_frameworks!

workspace 'demo.xcworkspace'

############## common dependence libs source ###############
targets=['demo', 'multicanvas']

targets.each do |tar|
    target tar do
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
        
        pod 'libksygpulive/libksygpulive_265',  '~> 3.0.0'
        
        pod 'KMCSTFilter'
        pod 'CTAssetsPickerController',  '~> 3.3.0'
        pod 'KMCVStab'
        pod 'FDFullscreenPopGesture', '1.1'
        # pod 'TZImagePickerController'
        pod 'SMPageControl'
    end
end
