require 'rails_helper'

feature 'User can sign in and out' do
  context 'user is not signed and on the homepage' do
    scenario 'should see and sign in link and a sign up link' do
      visit('/')
      expect(page).to have_link('Sign in')
      expect(page).to have_link('Sign up')
    end

    scenario 'should not see \'sign out\' link' do
      visit('/')
      expect(page).not_to have_link('Sign out')
    end
  end

  context 'user signed in on the homepage' do
    before do
      visit('/')
      click_link('Sign up')
      fill_in('Email', with: 'test@example.com')
      fill_in('Password', with: 'testtest')
      fill_in('Password confirmation', with: 'testtest')
      click_button('Sign up')
    end

    scenario 'should see \'sign out\' link' do
      visit('/')
      expect(page).to have_link('Sign out')
    end

    scenario 'should not see a \'sign in\' link and a \'sign up\' link' do
      visit('/')
      expect(page).not_to have_link('Sign in')
      expect(page).not_to have_link('Sign up')
    end
  end

end

feature 'Once logged in users' do

  scenario 'they can edit their restaurants' do
    sign_up_user1
    click_link('Add a restaurant')
    fill_in 'Name', with: 'Nandos'
    click_button 'Create Restaurant'
    expect(page).to have_content 'Nandos'
    expect(current_path).to eq '/restaurants'
    click_link('Sign out')
    expect(current_path).to eq '/'
    sign_up_user2
    click_link 'Edit Nandos'
    expect(current_path).to eq '/'
    expect(page).to have_content 'You are not allowed to edit this restaurant'
  end

  scenario 'they can delete their restaurants' do
    sign_up_user1
    click_link('Add a restaurant')
    fill_in 'Name', with: 'Nandos'
    click_button 'Create Restaurant'
    expect(page).to have_content 'Nandos'
    expect(current_path).to eq '/restaurants'
    click_link('Sign out')
    expect(current_path).to eq '/'
    sign_up_user2
    click_link 'Delete Nandos'
    expect(current_path).to eq '/'
    expect(page).to have_content 'You are not allowed to delete this restaurant'
  end

  # scenario 'they can only leave one review per restaurant' do
  #   sign_up_user1
  #   click_link('Add a restaurant')
  #   fill_in 'Name', with: 'Nandos'
  #   click_button 'Create Restaurant'
  #   expect(page).to have_content 'Nandos'
  #   expect(current_path).to eq '/restaurants'
  #   click_link('Review Nandos')
  #   fill_in "Thoughts", with: "so so"
  #   click_button 'Leave Review'
  #   expect(current_path).to eq '/restaurants'
  #   click_link('Review Nandos')
  #   fill_in "Thoughts", with: "fabby"
  #   click_button 'Leave Review'
  #   expect(page).to have_content 'You have already reviewed this restaurant'
  #   expect(page).not_to have_content 'fabby'
  # end

  def sign_up_user1
    visit('/users/sign_up')
    fill_in('Email', with: 'test@example.com')
    fill_in('Password', with: 'testtest')
    fill_in('Password confirmation', with: 'testtest')
    click_button('Sign up')
  end

  def sign_up_user2
    visit('/users/sign_up')
    fill_in('Email', with: 'a123@test.com')
    fill_in('Password', with: '12345678')
    fill_in('Password confirmation', with: '12345678')
    click_button('Sign up')
  end

end
