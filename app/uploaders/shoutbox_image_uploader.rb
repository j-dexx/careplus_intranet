class ShoutboxImageUploader < Chronicler::ImageUploader

  version :index, :from_version => :show do
    process :resize_to_fill => [160, 160]
  end

  version :show do
    process :resize_to_fill => [918, 300]
  end
  
  version :newsletter do
    process :resize_to_fill => [160, 121]
  end
end