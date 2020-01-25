Adding an article to My Blog means:

1. Creating a file for the article in the `views/articles` directory with a unique name, and
2. Recording that unique name in the `config/articles.yml` file 

These steps are accomplished by running `rails g article --title={some_title}` (where some_title doesn't have to be unique).

The unique filename (or `view_id`) will later be stored in the database against an Article record. When someone tries to view the Article (using its title or ID) we'll fetch it from the database, look up its `view_id`, and render the corresponding view from `views/articles`. This means the database in a given environment doesn't need to store the content of an article - that lives in the `views/articles` file - just data that will update as users interact with the site, such as view counts, reaction counts, and maybe attributes an admin wants to change without a fresh deploy.

The next step is:

3. storing the new article in the database

The database for each environment needs the new Article record to have the same `view_id`. This is accomplished by running `rails articles:sync`, which goes through the `config/articles.yml` list and creates any missing Article records with whatever `view_id` the list specifies. The command gets run whenever the blog is deployed, so the database is kept up-to-date with any new articles that have been added to `views/articles`.