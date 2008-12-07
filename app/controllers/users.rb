class Users < Application
  before :ensure_authenticated, :exclude=>[:new, :create, :index]
  before :authorize, :exclude=>[:new, :create, :index]

  provides :xml, :yaml, :json

  def index
    display '' # display... nothing.
  end

  def show(id)
    @user = User.get(id)
    raise NotFound unless @user
    display @user, display_options
  end

  def new
    only_provides :html
    @user = User.new
    display @user, display_options
  end

  def edit(id)
    only_provides :html
    @user = User.get(id)
    raise NotFound unless @user
    display @user, display_options
  end

  def create(user)
    @user = User.new(user)
    if @user.save
      session.abandon!
      session.user = @user
      
      redirect resource(@user), :message => {:notice => "User was successfully created"}
    else
      message[:error] = "User failed to be created"
      render :new
    end
  end

  def update(id, user)
    @user = User.get(id)
    raise NotFound unless @user
    if @user.update_attributes(user)
       redirect resource(@user)
    else
      display @user, :edit, display_options
    end
  end

  def destroy(id)
    @user = User.get(id)
    raise NotFound unless @user
    if @user.destroy
      redirect resource(:users)
    else
      raise InternalServerError
    end
  end
private

  def authorize
    user = User.get params[:id]
    raise Unauthorized.new unless user == session.user
  end
  
  # Hack to ensure that datamapper does not give out your password+salt
  def display_options
    {:exclude=>[:salt, :crypted_password]}
  end
end # Users
