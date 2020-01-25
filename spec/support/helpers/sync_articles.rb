require 'rails/commands'
require Rails.root.join('lib', 'commands', 'articles_command.rb')

module SyncArticles
  def sync_articles_from_config_to_database
    ArticlesCommand.new([]).sync
  end
end

RSpec.configure do |c|
  c.include SyncArticles
end