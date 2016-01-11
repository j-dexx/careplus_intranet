class PageImageUploader < Chronicler::ImageUploader

  version :show do
    process :resize_to_fit => [442, 300]
  end

  version :service_image do
    process :resize_to_fill => [160, 160]
  end

end
