class MemberImageUploader < Chronicler::ImageUploader

  version :index, :from_version => :show do
    process :resize_to_fill => [208, 208]
  end

  version :show do
    process :resize_to_fill => [208, 208]
  end
end