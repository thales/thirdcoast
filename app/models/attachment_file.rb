class AttachmentFile < Asset

  # === List of columns ===
  #   id                : integer 
  #   data_file_name    : string 
  #   data_content_type : string 
  #   data_file_size    : integer 
  #   assetable_id      : integer 
  #   assetable_type    : string 
  #   type              : string 
  #   locale            : integer 
  #   user_id           : integer 
  #   created_at        : datetime 
  #   updated_at        : datetime 
  # =======================

  has_attached_file :data,
                    :url => ":id/:filename",
                    # :path => ":rails_root/public/assets/attachments/:id/:filename"
                    :path => ":id/:filename",
                    :storage => :s3,
                    :s3_credentials => "#{RAILS_ROOT}/config/amazon_s3.yml",
                    :bucket => lambda { |photo| "#{(Rails.env.development? || Rails.env.staging? ? '' : '' )}3rdcoast-attachments" }
  # dev-
  validates_attachment_size :data, :less_than=>10.megabytes
end
