json.array!(@projects) do |project|
  json.extract! project, :id, :name, :description, :scm_type, :scm_reference
  json.url project_url(project, format: :json)
end
