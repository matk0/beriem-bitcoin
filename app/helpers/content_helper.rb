module ContentHelper
  def render_content(slug)
    file_path = Rails.root.join("content", "#{slug}.md")
    return nil unless File.exist?(file_path)

    content = File.read(file_path)
    frontmatter, body = parse_frontmatter(content)

    {
      frontmatter: frontmatter,
      body: Kramdown::Document.new(body).to_html.html_safe
    }
  end

  def render_navod(slug)
    file_path = Rails.root.join("content", "navody", "#{slug}.md")
    return nil unless File.exist?(file_path)

    content = File.read(file_path)
    frontmatter, body = parse_frontmatter(content)

    {
      frontmatter: frontmatter,
      body: Kramdown::Document.new(body).to_html.html_safe
    }
  end

  def navody_list
    Dir.glob(Rails.root.join("content", "navody", "*.md")).map do |file|
      slug = File.basename(file, ".md")
      next if slug == "index"

      content = File.read(file)
      frontmatter, _ = parse_frontmatter(content)

      {
        slug: slug,
        title: frontmatter["title"] || slug.titleize,
        description: frontmatter["description"]
      }
    end.compact
  end

  private

  def parse_frontmatter(content)
    if content.start_with?("---")
      parts = content.split("---", 3)
      if parts.length >= 3
        frontmatter = YAML.safe_load(parts[1]) || {}
        body = parts[2].strip
        return [frontmatter, body]
      end
    end

    [{}, content]
  end
end
