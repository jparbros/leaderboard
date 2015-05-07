class Subdomain
  def self.matches?(request)
    request.subdomain.present? && request.subdomain != 'www' && request.subdomain != 'demo' && request.subdomain != 'admin'
  end

  def self.admin?(request)
    request.subdomain.present? && request.subdomain == 'admin'
  end
end