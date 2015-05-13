class AddFieldsToEmails < ActiveRecord::Migration
  def change
    add_column :emails, :emails_sent, :integer
    add_column :emails, :archive_url, :string
  end
end
