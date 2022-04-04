require 'rails_helper'

RSpec.describe User, type: :model do
  it "factoryがvalidなインスタンスを生成すること" do
    expect(build(:user)).to be_valid
  end

  describe "バリデーション" do
    describe "nameザー名" do
      context "正常系" do
        context "nameの場合" do
          it "validになること" do
            valid_name = "a" * 1

            valid_user = build(:user, name: valid_name)
            valid_user.valid?

            expect(valid_user).to be_valid
            expect(valid_user.errors).to be_empty
          end
        end

        context "nameの場合" do
          it "validになること" do
            valid_name = "a" * 5

            valid_user = build(:user, name: valid_name)
            valid_user.valid?

            expect(valid_user).to be_valid
            expect(valid_user.errors).to be_empty
          end
        end

        context "nameの場合" do
          it "validになること" do
            valid_name = "a" * 20

            valid_user = build(:user, name: valid_name)
            valid_user.valid?

            expect(valid_user).to be_valid
            expect(valid_user.errors).to be_empty
          end
        end

        context "重複しないnameの場合" do
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
        context "nameの場合" do
          it "invalidになること" do
            invalid_user = build(:user, name: nil)
            invalid_user.valid?

            expect(invalid_user).to be_invalid
            expect(invalid_user.errors[:name]).to include "を入力してください" 
          end
        end

        context "nameの場合" do
          it "invalidになること" do
            invalid_name = "a" * 21

            invalid_user = build(:user, name: invalid_name)
            invalid_user.valid?

            expect(invalid_user).to be_invalid
            expect(invalid_user.errors[:name]).to include "は20文字以内で入力してください" 
          end
        end

        context "重複したnameの場合" do
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

    describe "lifespan" do
      context "正常系" do
        context "lifespanの値が1の場合" do
          it "validになること" do
            valid_user = build(:user, lifespan: 1)
            valid_user.valid?

            expect(valid_user).to be_valid
            expect(valid_user.errors).to be_empty
          end
        end

        context "lifespanの値が30の場合" do
          it "validになること" do
            valid_user = build(:user, lifespan: 30)
            valid_user.valid?

            expect(valid_user).to be_valid
            expect(valid_user.errors).to be_empty
          end
        end

        context "lifespanの値が100の場合" do
          it "validになること" do
            valid_user = build(:user, lifespan: 100)
            valid_user.valid?

            expect(valid_user).to be_valid
            expect(valid_user.errors).to be_empty
          end
        end
      end
  
      context "異常系" do
        context "lifespanの値が空の場合" do
          it "invalidになること" do
            invalid_user = build(:user, lifespan: nil)
            invalid_user.valid?

            expect(invalid_user).to be_invalid
            expect(invalid_user.errors[:lifespan]).to include "を入力してください" 
          end
        end

        context "lifespanの値が文字列の場合" do
          it "invalidになること" do
            invalid_user = build(:user, lifespan: "string")
            invalid_user.valid?

            expect(invalid_user).to be_invalid
            expect(invalid_user.errors[:lifespan]).to include "は数値で入力してください" 
          end
        end

        context "lifespanの値が少数の場合" do
          it "invalidになること" do
            invalid_user = build(:user, lifespan: 10.5)
            invalid_user.valid?

            expect(invalid_user).to be_invalid
            expect(invalid_user.errors[:lifespan]).to include "は整数で入力してください" 
          end
        end

        context "lifespanの値が負の値の場合" do
          it "invalidになること" do
            invalid_user = build(:user, lifespan: -1)
            invalid_user.valid?

            expect(invalid_user).to be_invalid
            expect(invalid_user.errors[:lifespan]).to include "は1以上の値にしてください" 
          end
        end

        context "lifespanの値が0の場合" do
          it "invalidになること" do
            invalid_user = build(:user, lifespan: 0)
            invalid_user.valid?

            expect(invalid_user).to be_invalid
            expect(invalid_user.errors[:lifespan]).to include "は1以上の値にしてください" 
          end
        end

        context "lifespanの値が101の場合" do
          it "invalidになること" do
            invalid_user = build(:user, lifespan: 101)
            invalid_user.valid?

            expect(invalid_user).to be_invalid
            expect(invalid_user.errors[:lifespan]).to include "は100以下の値にしてください" 
          end
        end
      end
    end
  end


  describe "インスタンスメソッド" do
    describe "#calc_death_anniversary" do
      before do
        travel_to Time.zone.local(2000, 1, 1)
      end

      context "正常系" do
        context "lifespanの値が1の場合" do
          it "death_anniversaryが2001年1月1日になること" do
            valid_user = build(:user, lifespan: 1)
            valid_user.calc_death_anniversary

            expect(valid_user.death_anniversary).to eq "1-1-2001".to_date
          end
        end

        context "lifespanの値が100の場合" do
          it "death_anniversaryが2100年1月1日になること" do
            valid_user = build(:user, lifespan: 100)
            valid_user.calc_death_anniversary

            expect(valid_user.death_anniversary).to eq "1-1-2100".to_date
          end
        end
      end
    end

    describe "#calc_remaining_hours" do
      context "正常系" do
        context "lifespanの値が1の場合" do
          it "計算結果が6_025時間になること" do
            valid_user = build(:user, lifespan: 1)
            remaining_hours = valid_user.calc_remaining_hours

            expect(remaining_hours).to eq 6_025
          end
        end

        context "lifespanの値が30の場合" do
          it "計算結果が186_150時間になること" do
            valid_user = build(:user, lifespan: 30)
            remaining_hours = valid_user.calc_remaining_hours

            expect(remaining_hours).to eq 186_150
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
