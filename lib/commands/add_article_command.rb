class AddArticleCommand < Rails::Command::Base
  include Thor::Actions
  
  desc "execute", "Adds a view for a new article and stores a view_id in config so it can be synced to the database"
  method_option :title, type: :string, desc: "What's the article called? This can change later"
  def execute
    require_application_and_environment!

    create_view
    add_to_config

    say "Done! Remember to update the database in each environment with `rails articles:sync`"
  end

  no_commands do
    def create_view
      say "Creating view"

      create_file "app/views/articles/_#{view_id}.html.erb", "# View for article #{options[:title]} with view ID #{view_id}"
    end

    def add_to_config
      say "Adding to config"

      append_to_file "config/articles.yml", article_config
    end

    def view_id
      @_view_id ||= [timestamp, random_string].join("_")
    end

    def random_string
      SecureRandom.hex(5)
    end

    def timestamp
      Time.now.strftime("%d%m%Y%H%M%S")
    end

    def article_config
      <<~CONFIG
        - view_id: #{view_id}
          title: #{options[:title]}
      CONFIG
    end
  end
end