require 'features_helper'

RSpec.feature 'Guest views an article', type: :feature do
  scenario 'They see the correct article' do
    sync_articles_from_config_to_database

    visit article_path Article.find_by(title: "Test")

    expect(page).to have_content "This is the test article"
  end
end