# Paperclip Configurations

PAPERCLIP_BASE_URL           = "/uploads"
PAPERCLIP_DEFAULT_PATH       = ":rails_root/public:url"
PAPERCLIP_DEFAULT_URL        = "#{PAPERCLIP_BASE_URL}/:class/:id_partition/:style.:extension"
PAPERCLIP_MISSING_URL        = "/static/images/missing.jpg" # "/static/images/missing-:style.jpg"

PAPERCLIP_IMAGE_SIZE_LIMIT   = 2.megabytes
PAPERCLIP_IMAGE_CONTENT_TYPE = /\Aimage/

Paperclip::Attachment.default_options.merge!({
  url:         PAPERCLIP_DEFAULT_URL,
  path:        PAPERCLIP_DEFAULT_PATH,
  default_url: PAPERCLIP_MISSING_URL
})

