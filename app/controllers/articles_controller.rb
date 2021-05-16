class ArticlesController < ApplicationController
  ROW_SIZE = 4

  def show 
    @article = Article.find(params[:id])
  end

  def index
    @articles = articles + top_ups
  end

  private

    def articles
      @_articles ||= fetch_articles
    end

    def fetch_articles
      Article.recent_first
    end

    def top_ups
      [ArticleComingSoon.new] * empty_row_positions
    end

    def empty_row_positions
      if row_positions_filled > 0
        ROW_SIZE - row_positions_filled
      else
        0
      end
    end

    def row_positions_filled
      articles.length % ROW_SIZE
    end
end