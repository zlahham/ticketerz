class Ticket < ActiveRecord::Base
  belongs_to :project
  validates :name, :description, presence: true, length: { minimum: 10}
end
