class User < ActiveRecord::Base
  has_many :articles, :dependent => :destroy

  # def articles(*)
  #   r = nil
  #   Octopus.using(country) { r = super }
  #   r
  # end
  #
  # def country
  #   if id.odd?
  #     "blue"
  #   else
  #     "green"
  #   end
  # end
end
