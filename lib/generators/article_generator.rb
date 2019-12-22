require "securerandom"

class ArticleGenerator < Rails::Generators::Base
	class_option :title, type: :string, required: false, desc: "What's the article called? This can change later"

  def create_partial
  	say "Creating partial"
    create_file "app/views/articles/_#{view_id}.html.erb", "# Partial for article with view ID #{view_id}"
  end

  def add_to_config
  	say "Adding to config"
  	append_to_file "config/articles.yml" do
		  article_config
		end
  end

  def complete
  	say "Remember to update the database with article:db:create"
  end

  private

  	def view_id
  		@_view_id ||= [random_string, timestamp].join("-")
  	end

  	def random_string
  		SecureRandom.hex(5)
  	end

  	def timestamp
  		Time.now.strftime("%d%m%Y-%H%M%S")
  	end

  	def article_config
  		<<~CONFIG
  			- view_id: #{view_id}
  				title: #{options[:title]}
  		CONFIG
  	end
end