require "date"

class Todo
  def initialize(text, due_date, completed)
    # Here i am creating the array of hash to store the todo detail
    @todoList = []
    @todoList.push({ :text => text, :due_date => due_date, :completed => completed })
  end

  # Here i am cheching if the todo is overdue or not,if it is overdue i will return that overdue todo only
  def overdue?
    @todoList[0][:due_date] < Date.today
  end

  # Here i am cheching if the todo date is today or not,if it is today i will return that todo only
  def due_today?
    @todoList[0][:due_date] == Date.today
  end

  # Here i am cheching if the todo will do in the future or not,if it is true i will return that todo only
  def due_later?
    @todoList[0][:due_date] > Date.today
  end

  # This is used to return the data of an particular todo list as a string
  def to_displayable_string
    # Here I am just checking if the toso for due later or not if it is yes i will return the due later todos
    # if it is not due later todos,it will due_today or overdue todos so i just return the todos with the completed state
    if @todoList[0][:due_date] > Date.today
      "[ ] #{@todoList[0][:text]} #{@todoList[0][:due_date]}"
    else
      todo_result = @todoList[0][:completed] ? "[X] #{@todoList[0][:text]} " : "[ ] #{@todoList[0][:text]} "
      @todoList[0][:due_date] == Date.today ? todo_result : "#{todo_result}#{@todoList[0][:due_date]}"
    end
  end
end

class TodosList
  def initialize(todos)
    @todos = todos
  end

  # This function is used to call the overdue? method to check the todo date and return the todo list belongs to the date
  def overdue
    TodosList.new(@todos.filter { |todo| todo.overdue? })
  end

  # This function is used to call the due_today? method to check the todo date and return the todo list belongs to the date
  def due_today
    TodosList.new(@todos.filter { |todo| todo.due_today? })
  end

  # This function is used to call the due_later? method to check the todo date and return the todo list belongs to the date
  def due_later
    TodosList.new(@todos.filter { |todo| todo.due_later? })
  end

  # This funtion is used to add the new todo in the todo list
  def add(new_todo)
    @todos.push(new_todo)
  end

  # This function is used to call the to_displayable_string method to create the todo list and return it as a string type
  def to_displayable_list
    @todos.map { |todo| todo.to_displayable_string }.join("\n")
  end
end

date = Date.today
todos = [
  { text: "Submit assignment", due_date: date - 1, completed: false },
  { text: "Pay rent", due_date: date, completed: true },
  { text: "File taxes", due_date: date + 1, completed: false },
  { text: "Call Acme Corp.", due_date: date + 1, completed: false },
]

# Here i am creating the array of Todo class objects
todos = todos.map { |todo|
  Todo.new(todo[:text], todo[:due_date], todo[:completed])
}

# Here i am creating the object for TodoList to work on it
todos_list = TodosList.new(todos)

# Add the new todo in the todo list
todos_list.add(Todo.new("Service vehicle", date, false))

puts "My Todo-list\n\n"

# This will display the overdue todos
puts "Overdue\n"
puts todos_list.overdue.to_displayable_list
puts "\n\n"

# This will display the today todos
puts "Due Today\n"
puts todos_list.due_today.to_displayable_list
puts "\n\n"

# This will display the later todos
puts "Due Later\n"
puts todos_list.due_later.to_displayable_list
puts "\n\n"
