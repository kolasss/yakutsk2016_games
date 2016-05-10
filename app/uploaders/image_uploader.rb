class ImageUploader < FileUploader
  include CarrierWave::MiniMagick

  def extension_white_list
    %w[
      jpg jpeg gif png
    ]
  end

  # version :cover do
  #   process resize_to_fill: [638, 418]
  # end

  # version :cover_small do
  #   process resize_to_fill: [308, 198]
  # end
end
