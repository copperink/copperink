class ImageAttachment
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paperclip
  include CreationScopes

  belongs_to :imageable, polymorphic: true

  field :default, type: Boolean

  has_mongoid_attached_file :data,
    styles: {
      thumb:  '120x120#',
      small:  '250x250>'
    },
    convert_options: {
      thumb:  '-quality 75 -strip',
      small:  '-quality 75 -strip'
    }

  default_scope { oldest_first }

  validates_attachment_presence     :data
  validates_attachment_size         :data, less_than:    PAPERCLIP_IMAGE_SIZE_LIMIT
  validates_attachment_content_type :data, content_type: PAPERCLIP_IMAGE_CONTENT_TYPE

  validates :default, uniqueness: { scope: :imageable }, if: :default?


  def name;                   data_file_name;   end
  def size;                   data.size;        end
  def url(size = :medium);    data.url(size);   end


  def undefault!
    update(default: false)
  end

  def default!
    imageable.default_image.undefault! if imageable.default_image
    update(default: true)
  end

end
