class UserImageUploader < CareplusImageUploader
  version :show do
    process :resize_to_fill => [100, 100]
  end
end