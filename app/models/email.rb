class Email < ActiveRecord::Base
  include EmailMailchimp

  attr_accessor :sent_total, :opened_total
end
