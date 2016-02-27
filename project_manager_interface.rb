class ProjectManagerInterface
  HELP_MENU = "
  Help Menu:
  help - Open this dialog
  view projects - Displays current projects
  add project - Add a project
  delete project - Removes a project
  save projects - Saves projects (located in 'projects.json' by default)
  write html - Writes projects to 'projects.html'
  open browser - Open projects in browser
  "

  def initialize(project_manager)
    @project_manager = project_manager
  end

  def display_projects
    projects.each do |group, sub_projects|
      puts "#{group.capitalize}: "
      sub_projects.each do |project_title, project_hash|
        display_single_project(project_hash)
      end
    end
  end

  def projects
    @project_manager.projects["projects"]
  end

  def display_project_groups
    projects.each do |group, sub_projects|
      puts "#{group.capitalize}: "
    end
  end

  def display_single_project(project_hash)
     project_hash.each do |key, value|
       puts "  #{key.capitalize}: #{value}"
     end
     puts ""
  end

  def next_action
    print 'Enter a command: '
    entry = gets.chomp.downcase
    case entry
    when 'help' then display_help; next_action
    when 'view projects' then display_projects; next_action
    when 'add project' then :add_project
    when 'save projects' then :save_projects
    when 'write html' then :write_html
    else :quit
    end
  end

  def ask_input(text = ": ")
    print text
    gets.chomp
  end

  def display_help
    puts HELP_MENU
  end

end