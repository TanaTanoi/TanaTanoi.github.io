require 'JSON'

class ProjectManager
  attr_reader :view, :projects
  def initialize
    @view = ProjectManagerInterface.new(self)
  end

  def start
    if File.exists?("project.json")
      open_projects
    else
      create_projects_file
    end
  end

  def add_project
    view.display_project_groups
    group = view.ask_input("What category?")
    return if !groups.include?(group) && !confirm_anwer("Create new group: #{group}? (y/n)")
    new_project = ask_projects_details
    groups[group] = groups[group] || {}
    groups[group][new_project["title"]] = new_project
  end

  def groups
    @projects["projects"]
  end

  def write_html
    file = File.new("test.html","w")
    file.puts PageTexts.new(projects).call
    file.close
  end

  def ask_projects_details
    title = view.ask_input("Title: ")
    description = view.ask_input("Description: ")
    image = view.ask_input("Image: ")
    url = view.ask_input("URL: ")
    {"title" => title, "description" => description, "image" => image, "url" => url}
  end

  def confirm_anwer(text)
    answer = ""
    answer = view.ask_input(text) until answer.match(/[yn]/)
    answer == "y"
  end

  def view_projects
    view.display_projects
  end

  def create_projects_file
    file = File.new("projects.json","w")
    @projects = {"projects" => {}}
    file.puts @projects.to_json
    file.close
  end

  def open_projects
    file = File.new("projects.json")
    @projects = JSON.parse(file.read)
    file.close
  end

  def save_projects
    file = File.new("projects.json","w")
    file.puts @projects.to_json
    file.close
  end
end