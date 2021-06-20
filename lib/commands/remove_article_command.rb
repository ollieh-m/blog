class RemoveArticleCommand < Rails::Command::Base
  include Thor::Actions

  desc "execute", "Removes the view and relevant config so the article will be removed from the database when the database is synced"
  method_option :view_id, type: :string
  def execute
    require_application_and_environment!

    remove_view
    remove_from_config

    say "Done! Remember to update the database in each environment with `rails sync_articles:execute`"
  end

  no_commands do
    def remove_view
      say "Removing view"

      remove_file "app/views/articles/_#{view_id}.html.erb"
    end

    def remove_from_config
      say "Removing from config"

      gsub_file "config/articles.yml", article_config_regex, ""
    end

    def view_id
      options[:view_id]
    end

    def article_config_regex
      /- view_id: #{Regexp.quote(view_id)}\s*title: .*$\n/
    end
  end
end