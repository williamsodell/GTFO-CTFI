# config/initializers/paperclip.rb
    # only use Amazon S2 on production servers
    unless Rails.env.development?
      Paperclip::Attachment.default_options[:url] = ':s3_alias_url'
      Paperclip::Attachment.default_options[:path] = 'images/:class/:id.:style.:extension'
      Paperclip::Attachment.default_options[:s3_host_alias] = 'cdn3.gtfo.cc'

    # # config/initializers/paperclip.rb
    # Paperclip::Attachment.default_options[:s3_host_name] = 's3-us-west-2.amazonaws.com'
    end