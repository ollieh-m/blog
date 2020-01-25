require 'yaml'

class ArticlesCommand < Rails::Command::Base
  desc "sync", "ensures articles in config/article.yml have a corresponding database record"
  def sync
    require_application_and_environment!

    articles_not_in_config.destroy_all

    articles_not_in_database.reverse.each do |article_attributes|
      Article.create(article_attributes)
    end
  end

  no_commands do
    def articles_not_in_config
      Article.where.not(view_id: view_ids_from_config)
    end

    def view_ids_from_config
      articles_from_config.map do |article_attributes|
        article_attributes["view_id"]
      end
    end

    def articles_from_config
      @_articles_from_config ||= YAML.load(File.open(Rails.root.join("config", "articles.yml"))) || []
    end

    def articles_not_in_database
      articles_from_config.reverse.take_while do |article_attributes|
        article_attributes["view_id"] != latest_persisted_view_id
      end
    end

    def latest_persisted_view_id
      @_latest_persisted_view_id ||= Article.recent_first.first&.view_id
    end
  end
end