class Book < ActiveRecord::Base
	validates :title, presence:true, length: {minimum: 3, maximum:50}

end