class TodoItem
  include DataMapper::Resource
  
  property :id, Serial
  property :done, Boolean,      :default=>false
  property :name, String,       :nullable=>false
  property :position, Integer
  
  belongs_to :user
  belongs_to :todo_list
end
