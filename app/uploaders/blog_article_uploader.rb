class BlogArticleUploader < Chronicler::ImageUploader

  version :index do
    process :resize_to_fill => [208, 208]
  end

  version :show do
    process :resize_to_fit => [459, 9999]
  end

  version :newsletter do
    process :resize_to_fill => [195, 135]
  end
end