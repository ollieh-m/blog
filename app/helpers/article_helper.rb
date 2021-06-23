module ArticleHelper
  def article_card_colour_classes(article)
    "bg-#{article.colour}-200 hover:bg-#{article.colour}-600 hover:text-#{article.colour}-200"
  end

  def italic(text = nil)
    tag.span class: "italic" do
      text || yield
    end
  end

  def title(text = nil)
    tag.div class: "text-5xl mb-2" do
      text || yield
    end
  end

  def subtitle(text = nil)
    tag.div class: "text-3xl mb-2" do
      text || yield
    end
  end

  def para(text = nil)
    tag.div class: "text-base mb-4" do
      text || yield
    end
  end

  def list
    items = capture do
      yield
    end.strip.split("\n")

    tag.ul class: "mt-4" do
      items.each do |item|
        concat(tag.li item.html_safe)
      end
    end
  end
end