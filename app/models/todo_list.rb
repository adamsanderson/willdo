class TodoList
  include DataMapper::Resource
  
  property :id, Serial
  property :name, String, :nullable=>false
  
  belongs_to :user
  has n, :todo_items
end
