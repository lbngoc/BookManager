class Book < ActiveRecord::Base
  belongs_to :author
  belongs_to :category

  attr_accessible :title, :year, :author_id, :category_id, :cover

  validates :title,  presence: true, length: { maximum: 255 }
  validates :year,  presence: true, 
  			numericality: { 
  				only_integer: true, 
  				greater_than_or_equal_to: 1970,
  				less_than: Date.current.year  				
  			}

  has_attached_file :cover,
                    :styles => { :medium => "300x300>", :thumb => "100x100>" },
                    :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :cover, :content_type => /\Aimage\/.*\Z/
  validates_attachment_file_name :cover, :matches => [/gif\Z/, /png\Z/, /jpe?g\Z/]
end
