require 'fox16'

include Fox

class StudentListView < FXMainWindow
    private attr_accessor :filters
    attr_accessor :font

    def initialize(app)
        super(app, "Students", width: 1024, height: 768)

        self.filters = {}

        main_frame = FXHorizontalFrame.new(self, LAYOUT_FILL)

        filter_segment = FXVerticalFrame.new(main_frame, LAYOUT_FIX_WIDTH, width: 250, padding: 15)
        setup_filter_segment(filter_segment)
    end

    def create
        super
        show(PLACEMENT_SCREEN)
    end

    def setup_filter_segment(parent)
        FXLabel.new(parent, "Фильтрация")

        FXLabel.new(parent, "Фамилия и инициалы:")
        initials_tbx = FXTextField.new(parent, 25)
        self.filters['name'] = {text_field: initials_tbx}

        add_filter_row(parent, "Github:")
        add_filter_row(parent, "Email:")
        add_filter_row(parent, "Phone:")
        add_filter_row(parent, "Telegram:")
    end

    def add_filter_row(parent, label)
        FXLabel.new(parent, label)
        cbx = FXComboBox.new(parent, 3, opts: LAYOUT_FIX_WIDTH | COMBOBOX_STATIC, width: 190)
        cbx.numVisible = 3
        cbx.appendItem("Не важно")
        cbx.appendItem("Да")
        cbx.appendItem("Нет")
        search_tbx = FXTextField.new(parent, 25)
        search_tbx.visible = false

        self.filters[label] = {combo_box: cbx, text_field: search_tbx}

        cbx.connect(SEL_COMMAND) do
            search_tbx.visible = (cbx.currentItem == 1)
            parent.recalc
        end
    end

end

app = FXApp.new
sv = StudentListView.new(app)
app.create
app.run