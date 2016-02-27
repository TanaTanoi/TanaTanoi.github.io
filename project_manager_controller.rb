class ProjectManagerController
  attr_reader :project_manager, :interface, :file_name

  DEFAULT_FILE_NAME = "projects.json"

  def initialize(project_manager, interface, file_name: DEFAULT_FILE_NAME)
    @project_manager = project_manager
    @interface = interface
    @file_name = file_name
  end

  def start
    initialize_projects
    interface.display_projects
    start_menu
  end

  def start_menu
    begin
      action = interface.next_action
      @project_manager.send(action)
    end until action == :quit
  end

  def initialize_projects
    if File.exists?(file_name)
      project_manager.open_projects
    else
      project_manager.create_projects_file
    end
  end
end