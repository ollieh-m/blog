class CodeSnippet
  FORMATTER = Rouge::Formatters::HTMLLineTable.new(Rouge::Formatters::HTML.new)
  LEXERS = {
    ruby: Rouge::Lexers::Ruby.new,
    shell: Rouge::Lexers::Shell.new,
    erb: Rouge::Lexers::ERB.new
  }

  def initialize(language, source_code)
    @language = language
    @source_code = source_code
  end

  def to_html
    FORMATTER.format(lexer.lex(left_aligned_source_code)).html_safe
  end

  private

    attr_reader :language, :source_code

    def lexer
      LEXERS[language]
    end

    def left_aligned_source_code
      lines.map do |line|
        line[(first_line_indentation - 1)..-1]
      end.join("\n")
    end

    def lines
      @_lines ||= split_lines
    end

    def split_lines
      source_code.split("\n").reject(&:empty?)
    end

    def first_line_indentation
      @_first_line_indentation ||= calculate_first_line_indentation
    end

    def calculate_first_line_indentation
      lines.first[/\A */].size
    end
end