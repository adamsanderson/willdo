module Merb
  module GlobalHelpers
    def breadcrumb(path=request.path)
      url = ''
      links = []
      path.split('/').reject{|p| p.blank? }.each do |p| 
        url += "/#{p}"
        links << link_to(p, url)
      end
      links.join(' / ')
    end
        
  end
end
