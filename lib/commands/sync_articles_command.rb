require 'yaml'

class SyncArticlesCommand < Rails::Command::Base
  desc "execute", "Ensures articles in config/articles.yml have a corresponding database record"
  def execute
    require_application_and_environment!

    destroy_articles_not_in_config
    create_articles_not_in_database

    say "Done!"
  end

  no_commands do
    def destroy_articles_not_in_config
      say "Destroying articles not in config"

      articles_not_in_config.destroy_all
    end

    def articles_not_in_config
      Article.where.not(view_id: view_ids_from_config)
    end

    def view_ids_from_config
      articles_from_config.map do |article_attributes|
        article_attributes["view_id"]
      end
    end

    def articles_from_config
      @_articles_from_config ||= load_articles_from_config
    end

    def load_articles_from_config
      YAML.load(File.open(config_file_path)) || []
    end

    def config_file_path
      Rails.root.join("config/articles.yml")
    end

    def create_articles_not_in_database
      say "Creating articles not in database"

      articles_not_in_database.reverse_each do |article_attributes|
        Article.create!(article_attributes)
      end
    end

    def articles_not_in_database
      articles_from_config.reject do |article_attributes|
        article_attributes["view_id"].in?(view_ids_from_database)
      end
    end

    def view_ids_from_database
      @_view_ids_from_database ||= fetch_view_ids_from_database
    end

    def fetch_view_ids_from_database
      Article.where(view_id: view_ids_from_config).pluck(:view_id)
    end
  end
end