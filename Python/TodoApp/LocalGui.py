import functions
import PySimpleGUI as gu
import time

gu.theme('DarkBlue15')

clock = gu.Text('', key='clock')
label = gu.Text("Type in a to-do")
input_box = gu.InputText(tooltip="Enter todo", key='todo')
add_button = gu.Button("Add")
list_box = gu.Listbox(values=functions.get_todos(), key='todos',
                      enable_events=True, size=[45,10])
edit_button = gu.Button('Edit')

complete_button = gu.Button('Complete')

exit_button = gu.Button("Exit")

window = gu.Window('My to-do app',
                   layout=[[clock],
                            [label],
                           [input_box, add_button],
                           [list_box, edit_button, complete_button],
                           [exit_button]],

                   font=('Helvetica', 20))

while True:
    event, values = window.read(timeout=1000)
    window['clock'].update(value=time.strftime("%A, %b %d, %Y %H:%M:%S"))
    match event:
        case 'Add':
            todos = functions.get_todos()
            new_todo = values['todo'] + '\n'
            todos.append(new_todo)
            functions.write_todos(todos)
            window['todos'].update(values=todos)

        case 'Edit':
            try:
                todo_edit = values['todos'][0]
                new_todo = values['todo']

                todos = functions.get_todos()
                index = todos.index(todo_edit)
                todos[index] = new_todo
                functions.write_todos(todos)
                window['todos'].update(values=todos)
            except IndexError:
                gu.Popup("Please select an item first.", font=("Helvetica", 20))

        case 'Complete':
            try:
                todo_to_complete = values['todos'][0]
                todos = functions.get_todos()
                todos.remove(todo_to_complete)
                functions.write_todos(todos)
                window['todos'].update(values=todos)
                window['todo'].update(value='')
            except IndexError:
                gu.Popup("Please select an item first.", font=("Helvetica", 20))

        case 'Exit':
            break

        case 'todos':
            window['todo'].update(value=values['todos'][0])

        case gu.WIN_CLOSED:
            break

window.close()
