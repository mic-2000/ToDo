require 'rails_helper'

describe "the signin process", :type => :feature, js: true do

  it "signs me in" do
    user = create(:user)
    visit '/users/sign_in'
    within("#new_user") do
      fill_in 'E-mail', :with => user.email
      fill_in 'Password', :with => user.password
    end
    click_button 'Sign in'
    expect(page).to have_text 'Signed in successfully.'
  end

  it "signs me out" do
    sign_in_js
    click_link 'Sign out'
    expect(page).to have_text 'You need to sign in or sign up before continuing.'
  end
end