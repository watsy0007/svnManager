class Project < ActiveRecord::Base
  has_many :projectusers, dependent: :destroy

  def as_json(options = {})
    super(options.merge(:include => :projectusers))
  end
end
