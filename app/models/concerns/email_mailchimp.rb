module EmailMailchimp
  extend ActiveSupport::Concern

  def create_campaign
    respond = ::GB.campaigns.create({
      type: "regular",
      options: {
        list_id: 'c798ed03ab',
        subject: subject,
        from_email: "contact@rankingdesk.com",
        from_name: "RankingDesk",
        generate_text: true,
        auto_footer: false
      }, content: {
        html: body}
    })
    update_email_from_respond(respond)
  end

  def update_campaign
    ::GB.campaigns.update({
      type: "regular",
      cid: mailchimp_id,
      name: 'content',
      value: {
        html: body
      }
    })

    ::GB.campaigns.update({
      type: "regular",
      cid: mailchimp_id,
      name: 'options',
      value: {
        subject: subject
      }
    })
  end

  def update_email_from_respond(respond)
    self.mailchimp_id = respond['id']
    self.emails_sent = respond['emails_sent']
    self.archive_url = respond['archive_url_long']
    save!
  end

  def send_campaign
    respond = ::GB.campaigns.send({cid: mailchimp_id})
    if respond['complete']
      update_attribute :email_sent, respond['complete']
    end
  end
end

# respond = ::GB.campaigns.send({cid: mailchimp_id})