Devise.setup do |config|
    config.secret_key = 'c15dbadd84ed26a126853b36c0f59a8c36a5e79e7961c53b681b5caac101a61d3b8456f52b44ce1d0279eecda2a33e998d7064e51ae9b7b8aa7accebfdae4c62'
    require 'devise/orm/active_record'
end