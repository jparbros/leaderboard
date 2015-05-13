class AddMailchimpIdToEmails < ActiveRecord::Migration
  def change
    add_column :emails, :mailchimp_id, :string
  end
end
