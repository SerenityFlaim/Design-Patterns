require 'fox16'

include Fox

class StudentApp < FXMainWindow

    def initialize(app)
        super(app, "Students", width: 1024, height: 768)

        tabs = FXTabBook.new(self, opts: LAYOUT_FILL)
        FXTabItem.new(tabs, "Student List", nil)
        student_list = FXVerticalFrame.new(tabs, opts: LAYOUT_FILL)

        FXTabItem.new(tabs, "Blank Tab", nil)
        second_tab = FXVerticalFrame.new(tabs, LAYOUT_FILL)

        FXTabItem.new(tabs, "Blank Tab", nil)
        third_tab = FXVerticalFrame.new(tabs)

        FXVerticalFrame.new(tabs, opts: LAYOUT_FILL)
    end

    def create
        super
        show(PLACEMENT_SCREEN)
    end

end

app = FXApp.new
sv = StudentApp.new(app)
app.create
app.run