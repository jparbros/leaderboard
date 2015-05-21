module Admin::ClientsHelper

  def link_to_with_order(name, attribute)
    link_to url_for(controller: controller_name, action: action_name, order: "#{attribute} #{asc_or_desc(attribute)}") do
      "#{name}<span class=\"glyphicon #{glyphicon_icon(attribute)}\" aria-hidden=\"true\"></span>".html_safe
    end
  end

  def asc_or_desc(attribute)
    if (params[:order] || '').match(attribute)
      (params[:order] || 'asc').match('asc') ? 'desc' : 'asc'
    else
      'desc'
    end
  end

  def glyphicon_icon(attribute)
    if (params[:order] || '').match(attribute)
      (params[:order] || 'asc').match('asc') ? 'glyphicon-sort-by-attributes-alt' : 'glyphicon-sort-by-attributes'
    else
      'glyphicon-sort-by-attributes'
    end
  end
end
