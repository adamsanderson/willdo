User.fixture {{
  :login                 => 'i_have_no_items',
  :email                 => "i_have_no_items@example.com",
  :password              => 'ohai!!!!',
  :password_confirmation => 'ohai!!!!'
}}

# Fixtures for a Cat
User.fixture(:cat){{
  :login                 => 'imacat',
  :email                 => "imacat@example.com",
  :password              => 'ohai!!!!',
  :password_confirmation => 'ohai!!!!',
  :todo_lists            => 3.of{ TodoList.make(:cat_list) }
}}

TodoList.fixture(:cat_list) {{
  :name         => 'list...',
  :todo_items   => 3.of{ TodoItem.make(:cat_task)},
  :user         => User.pick(:cat)
}}

TodoItem.fixture(:cat_task) {{
  :name         => 'todo...',
  :done         => false,
  :user         => User.pick(:cat)
}}