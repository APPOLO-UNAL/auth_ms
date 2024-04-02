class Denylist < ApplicationRecord
    include Devise::JWT::RevocationStrategies::Denylist
  end
  