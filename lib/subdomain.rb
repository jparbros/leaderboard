class Subdomain
  def self.matches?(request)
    request.subdomain.present? && ((request.subdomain != 'www' && request.subdomain != 'www' && request.subdomain != 'admin') || request.subdomain.match('assets'))
  end

  def self.admin?(request)
    request.subdomain.present? && request.subdomain == 'admin'
  end

  def self.assets?(request)
    request.subdomain.present? && request.subdomain.match('assets')
  end
end