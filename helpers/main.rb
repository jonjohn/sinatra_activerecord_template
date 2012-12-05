class TemplateApp < Sinatra::Application

  helpers do

    def url(*path_parts)
      escaped_path_parts = path_parts.map {|part| CGI.escape(part.to_s)}
      [ path_prefix, escaped_path_parts ].join("/").squeeze("/")
    end
    alias_method :u, :url
    
    def path_prefix
      request.env['SCRIPT_NAME']
    end
    
    def pagination_list(num_pages, current_page, border_pages=5)
      
      list = []
      list.push current_page

      # prepend previous pages
      i = current_page - 1
      count = 0
      while i >= 0 && count < border_pages do
        list.unshift(i)
        i -= 1
        count += 1
      end
      if (i >= 0)
        list.unshift(:ellipsis)
        list.unshift(0)
      end
      
      # append next pages
      i = current_page + 1
      count = 0
      while i < num_pages && count < border_pages do
        list.push(i)
        i += 1
        count += 1
      end
      if (i < num_pages)
        list.push(:ellipsis)
        list.push(num_pages - 1)
      end

      return list
    end

  end

end
