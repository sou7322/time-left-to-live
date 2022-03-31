require 'rails_helper'

RSpec.describe User, type: :model do
  it "factoryがvalidなインスタンスを生成すること" do
    expect(build(:user)).to be_valid
  end

  describe "バリデーション" do
    describe "ユーザー名" do
      context "正常系" do
        context "ユーザー名が1文字の場合" do
          it "validになること" do
            valid_name = "a" * 1

            valid_user = build(:user, name: valid_name)
            valid_user.valid?

            expect(valid_user).to be_valid
            expect(valid_user.errors).to be_empty
          end
        end

        context "ユーザー名が5文字の場合" do
          it "validになること" do
            valid_name = "a" * 5

            valid_user = build(:user, name: valid_name)
            valid_user.valid?

            expect(valid_user).to be_valid
            expect(valid_user.errors).to be_empty
          end
        end

        context "ユーザー名が20文字の場合" do
          it "validになること" do
            valid_name = "a" * 20

            valid_user = build(:user, name: valid_name)
            valid_user.valid?

            expect(valid_user).to be_valid
            expect(valid_user.errors).to be_empty
          end
        end

        context "重複しないユーザー名の場合" do
          it "validになること" do
            other_user = create(:user, name: "user")

            valid_user = build(:user, name: "james")
            valid_user.valid?

            expect(valid_user).to be_valid
            expect(valid_user.errors).to be_empty
          end
        end
      end

      context "異常系" do
        context "ユーザー名が0文字の場合" do
          it "invalidになること" do
            invalid_user = build(:user, name: nil)
            invalid_user.valid?

            expect(invalid_user).to be_invalid
            expect(invalid_user.errors[:name]).to include "を入力してください" 
          end
        end

        context "ユーザー名が21文字の場合" do
          it "invalidになること" do
            invalid_name = "a" * 21

            invalid_user = build(:user, name: invalid_name)
            invalid_user.valid?

            expect(invalid_user).to be_invalid
            expect(invalid_user.errors[:name]).to include "は20文字以内で入力してください" 
          end
        end

        context "重複したユーザー名の場合" do
          it "invalidになること" do
            other_user = create(:user, name: "user")

            duplicate_user = build(:user, name: "user")
            duplicate_user.valid?

            expect(duplicate_user).to be_invalid
            expect(duplicate_user.errors[:name]).to include "はすでに存在します" 
          end
        end
      end
    end
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
