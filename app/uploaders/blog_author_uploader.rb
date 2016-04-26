class BlogAuthorUploader < Chronicler::ImageUploader
  version :index do
    process resize_to_fill: [150, 150]
  end
end