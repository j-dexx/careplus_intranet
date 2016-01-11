class EventImageUploader < Chronicler::ImageUploader

  version :index, :from_version => :show do
    process :resize_to_fill => [208, 208]
  end

  version :homepage do
    process :resize_to_fill => [596, 336]
  end

  version :show do
    process :resize_to_fill => [918, 300]
  end
end