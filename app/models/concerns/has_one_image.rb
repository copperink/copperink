module HasOneImage
  extend ActiveSupport::Concern

  included do
    has_one :image_attachment, as: :imageable, dependent: :destroy

    def image
      image_attachment # || ImageAttachment.new
    end

    def image=(data)
      image_attachment(data)
    end

    def image_url
      image_attachment.try(:url, :original)
    end
  end

end
