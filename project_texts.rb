class ProjectTexts
  attr_reader :title, :url, :image, :description

  def initialize(title:, url: "", image: "", description: "Lorem Ipsem")
    @title = title
    @url = url
    @image = image
    @description = description
  end

  def call
    wrap_in_row_cell(project_entry_html)
  end

  private

  def title_html
    "<div class=\"project_title\">
      <h3 class=\"project_title\"> #{title} </h3>
    </div>
    "
  end

  def wrap_in_row_cell(content)
    "<div class='row'>
      <div class='cell'>
        #{content}
      </div>
    </div>"
  end

  def button_image_html
    "<div class='cell'>
      <a href='#{url}'>
        <img src='images/#{image}' class='project_icon'>
      </a>
    </div>"
  end

  def description_html
    "<div class='cell'>
      <p class='project_description'>
        #{description}
      </p>
    </div>"
  end

  def project_entry_html
    "#{title_html}
    <div class='project_entry'>
      #{button_image_html}
      #{description_html}
    </div>"
  end
end