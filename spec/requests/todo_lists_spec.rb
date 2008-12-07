require File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')

given "a todo_list exists" do
  TodoList.all.destroy!
  request(resource(:todo_lists), :method => "POST", 
    :params => { :todo_list => { :id => nil }})
end

describe "resource(:todo_lists)" do
  describe "GET" do
    
    before(:each) do
      @response = request(resource(:todo_lists))
    end
    
    it "responds successfully" do
      @response.should be_successful
    end

    it "contains a list of todo_lists" do
      pending
      @response.should have_xpath("//ul")
    end
    
  end
  
  describe "GET", :given => "a todo_list exists" do
    before(:each) do
      @response = request(resource(:todo_lists))
    end
    
    it "has a list of todo_lists" do
      pending
      @response.should have_xpath("//ul/li")
    end
  end
  
  describe "a successful POST" do
    before(:each) do
      TodoList.all.destroy!
      @response = request(resource(:todo_lists), :method => "POST", 
        :params => { :todo_list => { :id => nil }})
    end
    
    it "redirects to resource(:todo_lists)" do
      @response.should redirect_to(resource(TodoList.first), :message => {:notice => "todo_list was successfully created"})
    end
    
  end
end

describe "resource(@todo_list)" do 
  describe "a successful DELETE", :given => "a todo_list exists" do
     before(:each) do
       @response = request(resource(TodoList.first), :method => "DELETE")
     end

     it "should redirect to the index action" do
       @response.should redirect_to(resource(:todo_lists))
     end

   end
end

describe "resource(:todo_lists, :new)" do
  before(:each) do
    @response = request(resource(:todo_lists, :new))
  end
  
  it "responds successfully" do
    @response.should be_successful
  end
end

describe "resource(@todo_list, :edit)", :given => "a todo_list exists" do
  before(:each) do
    @response = request(resource(TodoList.first, :edit))
  end
  
  it "responds successfully" do
    @response.should be_successful
  end
end

describe "resource(@todo_list)", :given => "a todo_list exists" do
  
  describe "GET" do
    before(:each) do
      @response = request(resource(TodoList.first))
    end
  
    it "responds successfully" do
      @response.should be_successful
    end
  end
  
  describe "PUT" do
    before(:each) do
      @todo_list = TodoList.first
      @response = request(resource(@todo_list), :method => "PUT", 
        :params => { :todo_list => {:id => @todo_list.id} })
    end
  
    it "redirect to the article show action" do
      @response.should redirect_to(resource(@todo_list))
    end
  end
  
end

