require_relative 'project_manager_controller'
require_relative 'project_manager'
require_relative 'project_manager_interface'
require_relative 'project_texts'
require_relative 'page_texts'

model = ProjectManager.new
controller = ProjectManagerController.new(model,model.view)
controller.start