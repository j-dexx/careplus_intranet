class StaffBenefitImageUploader < Chronicler::ImageUploader

  version :index, :from_version => :show do
    process :resize_to_fill => [160, 160]
  end

  version :show do
    process :resize_to_fill => [299, 157]
  end
end