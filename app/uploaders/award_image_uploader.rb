class AwardImageUploader < Chronicler::ImageUploader

  version :index, :from_version => :show do
    process :resize_to_fill => [100, 100]
  end

  version :show do
    process :resize_to_fill => [200, 200]
  end
end