class User < ApplicationRecord
  # Enum
  enum role: { general: 0, admin: 10 }

  # Validation
  with_options presence: true do
    validates :name, length: { in: 1..20 }, uniqueness: true
  end
end

# == Schema Information
#
# Table name: users
#
#  id                :bigint           not null, primary key
#  death_anniversary :date             not null
#  lifespan          :integer          default(30), not null
#  name              :string(255)      default("noname"), not null
#  role              :integer          default("general"), not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
# Indexes
#
#  index_users_on_name  (name) UNIQUE
#
