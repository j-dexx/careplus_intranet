module FriendlyId
  class Slug < ActiveRecord::Base
    establish_connection "main_site_#{Rails.env}"
    self.table_name = "friendly_id_slugs"

    belongs_to :sluggable, :polymorphic => true
    before_save :set_type

    def set_type
      sluggable_type.slice!("MainSite")
      self.sluggable_type = sluggable_type
      #incase already exists, not as nice as friendly id but it'll do
      count = Slug.where("slug LIKE ? and sluggable_type = ?", "%#{slug}%", sluggable_type).count

      unless count == 0
        self.slug = "#{slug}-#{count + 1}"
      end
    end
    def to_param
      slug
    end
  end
end
