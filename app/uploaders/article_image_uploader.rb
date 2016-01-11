class ArticleImageUploader < Chronicler::ImageUploader

  version :index, :from_version => :show do
    process :resize_to_fill => [208, 208]
  end

  version :homepage do
    process :resize_to_fill => [612, 356]
  end

  version :show do
    process :resize_to_fill => [918, 300]
  end

  version :newsletter do
    process :resize_to_fill => [160, 121]
  end
end
