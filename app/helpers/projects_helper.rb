module ProjectsHelper
  def status_badge(project)
    case project.status
    when "In Progress"
      "bg-success"
    when "Halted"
      "bg-danger"
    when "Completed"
      "bg-info"
    else
      "bg-warning"
    end
  end
end
