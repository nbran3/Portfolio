from functions import get_todos, write_todos
import time

now = time.strftime("%A, %b %d, %Y %H:%M:%S")

while True:
    print("It is currently:", now)
    user_action = input("Type add, show, edit, or exit: ")
    user_actions = user_action.strip()

    if user_action.startswith('add'):
        todo = user_action[4:]

        todos = get_todos()

        todos.append(todo + '\n')

        write_todos(todos)

    elif user_action.startswith('show'):

        todos = get_todos()

        for index, item in enumerate(todos):
            item = item.strip('\n')
            item = item.title()
            row = f"{index + 1}: {item}"

            print(row)

    elif user_action.startswith('edit'):
        try:
            number = int(user_action[5:])
            print(number)

            number = number - 1

            todos = get_todos()

            new_todo = input("Enter a new todo: ")
            todos[number] = new_todo + '\n'

            write_todos(todos)

        except ValueError:
            print("Your command is not valid.")
            continue

    elif user_action.startswith('complete'):
        try:
            number = int(user_action[9:])

            todos = get_todos()

            index = number - 1
            removed_todo = todos[index].strip('\n')
            todos.pop(index)

            write_todos(todos)

            message = f'Todo {removed_todo} was removed from list.'
            print(message)

        except IndexError:
            print("There is no item with that number")
            continue

    elif user_action.startswith('exit'):
        break

    else:
        print("Invalid")

print("Bye!")
