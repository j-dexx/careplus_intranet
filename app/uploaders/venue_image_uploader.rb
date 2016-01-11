class VenueImageUploader < Chronicler::ImageUploader

  version :index, :from_version => :show do
    process :resize_to_fill => [94, 94]
  end
  
  version :show do
    process :resize_to_fill => [94, 94]
  end
end