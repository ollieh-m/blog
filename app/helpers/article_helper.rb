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

  def para(text = nil, extra_class: "")
    tag.div class: "text-base mb-4 #{extra_class}" do
      text || yield
    end
  end

  def line
    tag.div class: "border-b border-solid border-gray-200"
  end

  def list(&block)
    items = capture(&block).strip.split("\n")

    tag.ul class: "mt-4" do
      items.each do |item|
        concat(tag.li item.html_safe)
      end
    end
  end

  def inline_code(text = nil)
    tag.pre class: "bg-gray-200 inline" do
      text || yield
    end
  end

  def code(language:, &block)
    source_code = capture(&block)

    tag.div class: "highlight bg-gray-100 my-2 text-sm overflow-scroll" do
      CodeSnippet.new(language, source_code).to_html
    end
  end

  def link_to(*args, **options)
    options = options.reverse_merge(class: "text-blue-600 hover:underline")
    super(*args, **options)
  end

  def quote(&block)
    text = capture(&block).strip

    para extra_class: "ml-4" do
      italic "\"#{text}\""
    end
  end
end