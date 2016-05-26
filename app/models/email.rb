class Email < ActiveRecord::Base
  include Rails.application.routes.url_helpers

  has_many :email_items, :dependent => :destroy

  accepts_nested_attributes_for :email_items

  mount_uploader :image, EmailImageUploader

  before_create :set_list_name

  validates :list_id, :presence => true

  accepts_nested_attributes_for :email_items, reject_if: proc { |attributes| attributes['email_item_id'].blank? }

  def self.templates
    ['Newsletter']
  end

  def create_campaign
    api = Mailchimp::API.new('01e4730feb63b653b84f5e90cc0f90d0-us3')

    # campaignCreate(string apikey, string type, array options, array content, array segment_opts, array type_opts)
    campaign_id = api.campaignCreate(
      'type' => 'regular',
      'options' => {
        'list_id' => list_id,
        'subject' => subject,
        'from_email' => 'careplus@eskimosoup.co.uk',
        'from_name' => 'Care Plus Group',
        'to_name' => 'Care Plus Group Newsletter Subscribers',
        'auto_footer' => true
       },
      'content' => {
        'url' => email_url(self, :host => ActionMailer::Base.default_url_options[:host])
      }
    )

    update_attribute(:campaign_id, campaign_id)
  end

  def update_campaign
    api = Mailchimp::API.new('01e4730feb63b653b84f5e90cc0f90d0-us3')

    # campaignUpdate(string apikey, string cid, string name, mixed value)
    api.campaignUpdate('cid' => campaign_id, 'name' => 'subject', 'value' => subject)
    api.campaignUpdate(
      'cid' => campaign_id,
      'name' => 'content',
      'value' => { 'url' => email_url(self, :host => ActionMailer::Base.default_url_options[:host]) }
    )
  end

  def send_test
    api = Mailchimp::API.new('01e4730feb63b653b84f5e90cc0f90d0-us3')

    # campaignSendTest(string apikey, string cid, array test_emails, string send_type)
    api.campaignSendTest('cid' => campaign_id, 'test_emails' => [SITE_SETTINGS['Email']], 'send_type' => 'html')
  end

  def send_now
    api = Mailchimp::API.new('01e4730feb63b653b84f5e90cc0f90d0-us3')

    # campaignSendNow(string apikey, string cid)
    if api.campaignSendNow('cid' => campaign_id)
      update_attribute(:campaign_sent, true)
    end
  end

  def set_list_name
    self.list_name = Email.campaigns.rassoc("#{list_id}").first
  end

  def self.campaigns
    api = Mailchimp::API.new('01e4730feb63b653b84f5e90cc0f90d0-us3')

    list = api.lists
    unless list.blank? or list["data"].blank?
      campaigns = list["data"].map{|x| x.values_at("name", "id")}
    else
      campaigns = []
    end
  end

end
