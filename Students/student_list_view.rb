require 'fox16'
require './data_list_student_short.rb'
require './student.rb'
require_relative 'data_table/data_table.rb'

include Fox

class StudentListView < FXMainWindow
    private attr_accessor :filters, :table, :prev_button, :next_button, :total_pages, :items_per_page, :page_index, :current_page

    def initialize(app)
        super(app, "Students", width: 1024, height: 768)

        self.filters = {}
        self.current_page = 1
        self.items_per_page = 20
        self.total_pages = 0

        main_frame = FXHorizontalFrame.new(self, LAYOUT_FILL)

        filter_segment = FXVerticalFrame.new(main_frame, LAYOUT_FIX_WIDTH, width: 220, padding: 15)
        setup_filter_segment(filter_segment)

        table_segment = FXVerticalFrame.new(main_frame, LAYOUT_FILL, padding: 10)
        setup_table_segment(table_segment)
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
        cbx = FXComboBox.new(parent, 3, opts: LAYOUT_FILL_X | COMBOBOX_STATIC)
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

    def setup_table_segment(parent)
        self.table = FXTable.new(parent, opts: LAYOUT_FILL | TABLE_READONLY | TABLE_COL_SIZABLE)
        self.table.setTableSize(self.items_per_page, 4)
        self.table.setColumnWidth(0, 30)
        (1..3).each {|col| self.table.setColumnWidth(col, 220)}
        self.table.rowHeaderWidth = 0
        self.table.columnHeaderHeight = 0

        self.table.connect(SEL_COMMAND) do |_, _, pos|
            if pos.row == 0 && pos.col == 1
                sort_table_by_column(pos.col)
            end

            if pos.col == 0
                self.table.selectRow(pos.row)
            end
        end

        navigation_segment = FXHorizontalFrame.new(parent, opts: LAYOUT_FILL_X)
        self.prev_button = FXButton.new(navigation_segment, "<<<", opts: LAYOUT_LEFT)
        self.page_index = FXButton.new(navigation_segment, "1", opts: LAYOUT_CENTER_X)
        self.next_button = FXButton.new(navigation_segment, ">>>", opts: LAYOUT_RIGHT)

        #hardcode example
        self.table.setItemText(1, 0, "1")
        self.table.setItemText(1, 1, "Матюха Ф.А.")
        self.table.setItemText(1, 2, "https://github.com/SerenityFlaim")
        self.table.setItemText(1, 3, "telegram: @Serenity_flaim")

        self.table.setItemText(2, 0, "2")
        self.table.setItemText(2, 1, "Лотарев С.Ю.")
        self.table.setItemText(2, 2, "https://github.com/LotarV")
        self.table.setItemText(2, 3, "telegram: @LotarV")

        self.table.setItemText(3, 0, "3")
        self.table.setItemText(3, 1, "Смирнов Н.О.")
        self.table.setItemText(3, 2, "https://github.com/Zaiiiran")
        self.table.setItemText(3, 3, "telegram: @Zaiiiran")

        align_table_items
    end

    def align_table_items
        self.table.numRows.times do |row|
            self.table.numColumns.times do |col|
              self.table.setItemJustify(row, col, FXTableItem::LEFT | FXTableItem::TOP)
            end
        end
    end

    def read_table_from_view
        table = []
        (1...self.table.numRows).each do |row|
            row_data = []
            (0...self.table.numColumns).each do |col|
                row_data << self.table.getItemText(row, col)
            end
            break if row_data.all? {|attribute| attribute  == ""}

            table << row_data
        end
        return table
    end

    def sort_table_by_column(col_ix)
        table = read_table_from_view
        list = []

        table.each do |row|
            list << Student_short.new_from_id_string(row[0], "#{row[1]} #{row[2]} #{row[3]}")
        end

        dl_stud_short = DataList_student_short.new(list)
        sorted_table = dl_stud_short.get_data
        
        (0...sorted_table.get_logs_count).each do |row|
            (0...sorted_table.get_columns_count).each do |col|
                self.table.setItemText(row, col, sorted_table.get_element(row, col).to_s)
            end
        end
    end

end

app = FXApp.new
sv = StudentListView.new(app)
app.create
app.run