class TodoItems < Application
  before :ensure_authenticated
  before :get_scope
  before :authorize
  
  provides :xml, :yaml, :json

  def index
    @todo_items = @todo_list.todo_items.all.to_a
    display @todo_items
  end

  def show(id)
    @todo_item = @todo_list.todo_items.get(id)
    raise NotFound unless @todo_item
    display @todo_item
  end

  def new
    only_provides :html
    @todo_item = @todo_list.todo_items.new
    display @todo_item
  end

  def edit(id)
    only_provides :html
    @todo_item = @todo_list.todo_items.get(id)
    raise NotFound unless @todo_item
    display @todo_item
  end

  def create(todo_item)
    @todo_item = @todo_list.todo_items.new(todo_item)
    if @todo_item.save
      redirect resource(@user, @todo_list, @todo_item), :message => {:notice => "TodoItem was successfully created"}
    else
      message[:error] = "TodoItem failed to be created"
      render :new
    end
  end

  def update(id, todo_item)
    @todo_item = @todo_list.todo_items.get(id)
    raise NotFound unless @todo_item
    if @todo_item.update_attributes(todo_item)
       redirect resource(@user, @todo_list, @todo_item)
    else
      display @todo_item, :edit
    end
  end

  def destroy(id)
    @todo_item = @todo_list.todo_items.get(id)
    raise NotFound unless @todo_item
    if @todo_item.destroy
      redirect resource(@user, @todo_list, :todo_items)
    else
      raise InternalServerError
    end
  end
  
  private
  def get_scope
    @user = User.get params[:user_id]
    raise NotFound unless @user
    @todo_list = @user.todo_lists.get params[:todo_list_id]
    raise NotFound unless @todo_list
  end
  def authorize
    raise Unauthorized.new unless @user == session.user
  end
end # TodoItems
