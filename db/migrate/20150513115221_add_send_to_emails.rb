class AddSendToEmails < ActiveRecord::Migration
  def change
    add_column :emails, :email_sent, :boolean, default: false
  end
end
