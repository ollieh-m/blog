Adding an article to My Blog means:

1. Creating a file for the article in the `views/articles` directory with a unique name, and
2. Recording that unique name in the `config/articles.yml` file 

These steps are accomplished by running `bin/rails add_article:execute --title={some title}` (where some title doesn't have to be unique).

The unique filename (or `view_id`) will later be stored in the database against an article record. When someone tries to view the article (using its ID) we'll fetch it from the database, look up its `view_id`, and render the corresponding partial from `views/articles`. This means the database in a given environment doesn't need to store the content of an article - that lives in the `views/articles` file - just data that will update as users interact with the site, such as view counts, reaction counts, and maybe attributes an admin wants to change without a fresh deploy.

The next step is:

3. storing the new article in the database

The database for each environment needs the new article record to have the same `view_id`. This is accomplished by running `bin/rails sync_articles:execute`, which goes through the `config/articles.yml` list and creates any missing article records with whatever `view_id` the list specifies. The command gets run whenever the blog is deployed, so the database is kept up-to-date with any new articles that have been added to `views/articles`.