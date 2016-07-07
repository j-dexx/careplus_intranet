class Email < ActiveRecord::Base
  include Rails.application.routes.url_helpers

  has_many :email_items, dependent: :destroy

  accepts_nested_attributes_for :email_items

  mount_uploader :image, EmailImageUploader

  before_create :set_list_name

  validates :list_id, presence: true

  accepts_nested_attributes_for :email_items, reject_if: proc { |attributes| attributes['email_item_id'].blank? }

  def self.templates
    ['Newsletter']
  end

  def api
    Mailchimp::API.new(ENV['MAILCHIMP_API_KEY'])
  end

  def create_campaign
    # campaignCreate(string apikey, string type, array options, array content, array segment_opts, array type_opts)
    campaign_id = api.campaigns.create(
      'regular',
      {
        'list_id' => list_id,
        'subject' => subject,
        'from_email' => 'careplus@eskimosoup.co.uk',
        'from_name' => 'Care Plus Group',
        'to_name' => 'Care Plus Group Newsletter Subscribers',
        'auto_footer' => true
      },
      'url' => email_url(self, host: ActionMailer::Base.default_url_options[:host])
    )

    update_attribute(:campaign_id, campaign_id)
  end

  def update_campaign
    # campaignUpdate(string apikey, string cid, string name, mixed value)
    api.campaigns.update(campaign_id, 'subject', subject)
    api.campaigns.update(
      campaign_id,
      'content',
      'url' => email_url(self, host: ActionMailer::Base.default_url_options[:host])
    )
  end

  def send_test
    # campaignSendTest(string apikey, string cid, array test_emails, string send_type)
    api.campaigns.send_test(campaign_id, [SITE_SETTINGS['Email']], 'html')
  end

  def send_now
    # campaignSendNow(string apikey, string cid)
    if api.campaignSendNow('cid' => campaign_id)
      update_attribute(:campaign_sent, true)
    end
  end

  def set_list_name
    self.list_name = Email.campaigns.rassoc(list_id.to_s).first
  end

  def self.campaigns
    list = api.lists.list
    campaigns = if list.blank? || list['data'].blank?
                  []
                else
                  list['data'].map { |x| x.values_at('name', 'id') }
                end
  end
end
