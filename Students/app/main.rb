require_relative 'view/student_list_view.rb'

app = FXApp.new
sv = StudentListView.new(app)
app.create
app.run