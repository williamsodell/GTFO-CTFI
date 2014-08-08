class Countdown < ActiveRecord::Base
  def days
    (Time.zone.today - date).to_i
  end
end
