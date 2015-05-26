class EmailTemplate < ActiveRecord::Base

  before_save :clean_entities

  private

  def clean_entities
    self.body = self.body.gsub('&lt;', '<').gsub('&gt;', '>') if body
  end

end
