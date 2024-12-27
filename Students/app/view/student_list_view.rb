require 'fox16'
require_relative '../../models/data_list/data_list_student_short'
require_relative '../../models/student.rb'
require_relative '../../models/data_table/data_table.rb'
require_relative '../controller/student_list_controller.rb'

include Fox

class StudentListView < FXMainWindow
    private attr_accessor :filters, :table, :prev_button, :next_button, :total_pages, :page_index,  :delete_button, :edit_button, :controller, :selected_rows
    attr_accessor :current_page, :items_per_page

    def initialize(app)
        super(app, "Students View", width: 1024, height: 768)

        self.controller = Student_list_controller.new(self)
        self.filters = {}
        self.current_page = 1
        self.items_per_page = 6
        self.total_pages = 0

        main_frame = FXHorizontalFrame.new(self, LAYOUT_FILL)

        filter_segment = FXVerticalFrame.new(main_frame, LAYOUT_FIX_WIDTH, width: 220, padding: 15)
        setup_filter_segment(filter_segment)

        table_segment = FXVerticalFrame.new(main_frame, LAYOUT_FILL, padding: 10)
        setup_table_segment(table_segment)

        crud_segment = FXVerticalFrame.new(main_frame, LAYOUT_FIX_WIDTH, width: 130, padding: 10)
        setup_crud_segment(crud_segment)

        self.current_page = 1
        self.controller.refresh_data
        update_buttons_state
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

        FXButton.new(parent, "Сбросить", opts: BUTTON_NORMAL).connect(SEL_COMMAND) do
            reset_filters(parent)
            parent.recalc
        end
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
                self.controller.sort_table_by_column
                self.controller.refresh_data
            end

            if pos.col == 0
                self.table.selectRow(pos.row)
            end

            update_buttons_state
        end

        navigation_segment = FXHorizontalFrame.new(parent, opts: LAYOUT_FILL_X)
        self.prev_button = FXButton.new(navigation_segment, "<<<", opts: LAYOUT_LEFT | BUTTON_NORMAL)
        self.page_index = FXButton.new(navigation_segment, "1", opts: LAYOUT_CENTER_X)
        self.next_button = FXButton.new(navigation_segment, ">>>", opts: LAYOUT_RIGHT | BUTTON_NORMAL)

        self.prev_button.connect(SEL_COMMAND) {change_page(-1)}
        self.next_button.connect(SEL_COMMAND) {change_page(1)}

        align_table_items
    end

    def setup_crud_segment(parent)
        FXLabel.new(parent, "CRUD", opts: LAYOUT_FILL_X)

        add_button = FXButton.new(parent, "Добавить", opts: LAYOUT_FILL_X | BUTTON_NORMAL)
        add_button.connect(SEL_COMMAND) do
            self.controller.create
        end

        self.delete_button = FXButton.new(parent, "Удалить", opts: LAYOUT_FILL_X | BUTTON_NORMAL)
        delete_button.connect(SEL_COMMAND) do
            delete_logs
        end

        self.edit_button = FXButton.new(parent, "Изменить", opts: LAYOUT_FILL_X | BUTTON_NORMAL)
        edit_button.connect(SEL_COMMAND) do
            update_log
        end

        refresh_button = FXButton.new(parent, "Обновить", opts: LAYOUT_FILL_X | BUTTON_NORMAL)
        refresh_button.connect(SEL_COMMAND) do
            self.controller.renew
        end
        self.table.connect(SEL_CHANGED) {update_buttons_state}
    end

    def update_buttons_state
        selected_rows = (0...self.table.numRows).select {|row| self.table.rowSelected?(row)}
        self.delete_button.enabled = !selected_rows.empty?
        self.edit_button.enabled = (selected_rows.size == 1)
    end

    def change_page(offset)
        new_page = self.current_page + offset
        return if new_page < 1 || new_page > self.total_pages
        self.current_page = new_page
        self.controller.refresh_data
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

    def set_table_params(column_names, logs_count)
        column_names.each_with_index do |name, index|
            self.table.setItemText(0, index, name)
        end

        self.total_pages = (logs_count / (self.items_per_page - 1).to_f).ceil
        self.page_index.text = "#{self.current_page} из #{self.total_pages}"
    end

    def set_table_data(data_table)
        clear_table
        (0...data_table.get_logs_count).each do |row|
            (0...data_table.get_columns_count).each do |col|
                self.table.setItemText(row, col, data_table.get_element(row, col).to_s)
            end
        end
    end

    def clear_table
        (0...self.table.numRows).each do |row|
            (0...self.table.numColumns).each do |col|
                self.table.setItemText(row, col, "")
            end
        end
    end

    def reset_filters(parent)
        self.filters.each do |key, field|
            field[:combo].setCurrentItem(0) if !field[:combo].nil?
            field[:text_field].text = ""
            field[:text_field].visible = false if key != 'name'
        end

        parent.each_child do |child|
            if child.is_a?(FXComboBox)
                child.setCurrentItem(0)
            end
        end
    end

    def update_log
        self.selected_rows = []
        (0...self.table.numRows).each do |row_ix|
            self.selected_rows << row_ix if self.table.rowSelected?(row_ix)
        end
        self.controller.update(self.selected_rows[0])
    end

    def delete_logs
        self.selected_rows = []
        (0...self.table.numRows).each do |row_ix|
            self.selected_rows << row_ix if self.table.rowSelected?(row_ix)
        end
        self.controller.delete(self.selected_rows)
    end

    def show_error_message(message)
        if self.created?
            FXMessageBox.error(self, MBOX_OK, "Ошибка", message)
        else
            puts "Ошибка #{message}"
        end
    end

end