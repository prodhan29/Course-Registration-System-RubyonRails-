json.extract! regdetail, :id, :user_id, :semester_id, :course, :cgpa, :created_at, :updated_at
json.url regdetail_url(regdetail, format: :json)