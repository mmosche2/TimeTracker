class Project < ActiveRecord::Base
	has_many :entries
	belongs_to :user
	
	validates :name, :presence => true
	validates_uniqueness_of :name, :case_sensitive => false


end
