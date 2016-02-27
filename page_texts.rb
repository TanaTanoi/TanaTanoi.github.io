class PageTexts
  attr_reader :projects

  DEFAULT_TEMPLATE_FILE = "projects_template.html"
  DEFAULT_TEMPLATE_KEY = "<!--#INSERT_CONTENT_HERE#-->"

  def initialize(projects)
    @projects = projects
  end

  def call
    projects_page_template_html.sub(DEFAULT_TEMPLATE_KEY, all_groups_html)
  end

  private

  def projects_page_template_html
    @projects_page_template_html ||= File.new(DEFAULT_TEMPLATE_FILE).read
  end

  def all_groups_html
    projects.inject("") do |html,(key, group)|
      "#{html} \n #{group_html(group)}"
    end
  end

  def group_html(group)
    "<div class='projects_set'>
      <h2>#{group_title(group)}</h2>
      <div class='container project_entries'>
        #{group_projects_html(group.first.last)}
      </div>
    </div>"
  end

  def group_projects_html(projects)
    projects.inject("") do |html, (key, hash)|
      project_html = ProjectTexts.new( title: hash["title"],
                                      description: hash["description"],
                                      url: hash["url"],
                                      image: hash["image"]
                                    ).call
      "#{html} \n #{project_html}"
    end
  end

  def group_title(group)
    group.first.first.capitalize
  end
end