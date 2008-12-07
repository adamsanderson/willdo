class TodoLists < Application
  before :ensure_authenticated
  before :get_scope
  before :authorize
  
  provides :xml, :yaml, :json

  def index
    @todo_lists = @user.todo_lists.to_a
    display @todo_lists
  end

  def show(id)
    @todo_list = @user.todo_lists.get(id)
    raise NotFound unless @todo_list
    display @todo_list
  end

  def new
    only_provides :html
    @todo_list = @user.todo_lists.new
    display @todo_list
  end

  def edit(id)
    only_provides :html
    @todo_list = @user.todo_lists.get(id)
    raise NotFound unless @todo_list
    display @todo_list
  end

  def create(todo_list)
    @todo_list = @user.todo_lists.new(todo_list)
    if @todo_list.save
      redirect resource(@user, @todo_list), :message => {:notice => "TodoList was successfully created"}
    else
      message[:error] = "TodoList failed to be created"
      render :new
    end
  end

  def update(id, todo_list)
    @todo_list = @user.todo_lists.get(id)
    raise NotFound unless @todo_list
    if @todo_list.update_attributes(todo_list)
       redirect resource(@user, @todo_list)
    else
      display @todo_list, :edit
    end
  end

  def destroy(id)
    @todo_list = @user.todo_lists.get(id)
    raise NotFound unless @todo_list
    if @todo_list.destroy
      redirect resource(@user, :todo_lists)
    else
      raise InternalServerError
    end
  end

  private
    
  def get_scope
    @user = User.get params[:user_id]
    raise NotFound unless @user
  end
  
  def authorize
    raise Unauthorized.new unless @user == session.user
  end
end # TodoLists
