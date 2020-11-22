module ArticleHelper
  def article_card_colour_classes(article)
    "bg-#{article.colour}-200 hover:bg-#{article.colour}-600 hover:text-#{article.colour}-200"
  end
end