Pod::Spec.new do |s|
  s.name         = "YFUtils"    
  s.version      = "0.0.2"      
  s.summary      = "a repository demo"  
  s.description  = "a repository demo"  
  s.homepage     = "https://github.com/Abel0101/YFUtils"     
  s.license      = { :type => "MIT", :file => "LICENSE" }  
  s.author             = { "竹香" => "2603443950@qq.com" }  
  s.platform     = :ios, "9.0"                  
  s.source       = { :git => "https://github.com/Abel0101/YFUtils.git", :tag => "0.0.2" }        
  s.source_files  =  "YFDemo/YFDemo/Utils/**/*.{h,m}" 
  s.requires_arc = true 
  

end
