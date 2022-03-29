FactoryBot.define do
  factory :user do
    sequence(:name, "user_0")

    # エラー回避のため一時的に設定
    death_anniversary { Time.local(2030, 1, 1) }
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
