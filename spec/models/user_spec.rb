require 'rails_helper'

describe User do

  it 'has a valid factory' do
    expect(FactoryGirl.build(:user)).to be_valid
  end

  it 'is invalid without a first name' do
    user = FactoryGirl.build(:user, first_name: nil)
    user.valid?
    expect(user.errors[:first_name]).to include("can't be blank")
  end

  it 'is invalid without a last name' do
    user = FactoryGirl.build(:user, last_name: nil)
    user.valid?
    expect(user.errors[:last_name]).to include("can't be blank")
  end

  it 'is invalid without a username' do
    user = FactoryGirl.build(:user, username: nil)
    user.valid?
    expect(user.errors[:username]).to include("can't be blank")
  end

  it 'is invalid with a duplicate username' do
    FactoryGirl.create(:user, username: 'tester')
    user = FactoryGirl.build(:user, username: 'tester')
    user.valid?
    expect(user.errors[:username]).to include("has already been taken")
  end

  it 'is invalid without an email address' do
    user = FactoryGirl.build(:user, email: nil)
    user.valid?
    expect(user.errors[:email]).to include("can't be blank")
  end

  it 'is invalid with a duplicate email' do
    FactoryGirl.create(:user, email: 'tester@aol.com')
    user = FactoryGirl.build(:user, email: 'tester@aol.com')
    user.valid?
    expect(user.errors[:email]).to include("has already been taken")
  end

  it 'is invalid without a zip code' do
    user = FactoryGirl.build(:user, zip_code: nil)
    user.valid?
    expect(user.errors[:zip_code]).to include("is the wrong length (should be 5 characters)")
  end

  it 'is invalid with a zip code with a length other than 5' do
    user = FactoryGirl.build(:user, zip_code: 123456)
    user.valid?
    expect(user.errors[:zip_code]).to include("is the wrong length (should be 5 characters)")
  end

  it 'is invalid without a password' do
    user = FactoryGirl.build(:user, password: nil)
    user.valid?
    expect(user.errors[:password]).to include("can't be blank")
  end

  it 'is invalid when a password length is less that 6' do
    user = FactoryGirl.build(:user, password: 'bana')
    user.valid?
    expect(user.errors[:password]).to include("is too short (minimum is 6 characters)")
  end

  it 'is invalid when a password length is greater than 20' do
    user = FactoryGirl.build(:user, password: 'banananananananananan')
    user.valid?
    expect(user.errors[:password]).to include("is too long (maximum is 20 characters)")
  end

end