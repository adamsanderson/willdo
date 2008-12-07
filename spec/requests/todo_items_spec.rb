require File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')

given "a todo_item exists" do
  TodoItem.all.destroy!
  request(resource(:todo_items), :method => "POST", 
    :params => { :todo_item => { :id => nil }})
end

describe "resource(:todo_items)" do
  describe "GET" do
    
    before(:each) do
      @response = request(resource(:todo_items))
    end
    
    it "responds successfully" do
      @response.should be_successful
    end

    it "contains a list of todo_items" do
      pending
      @response.should have_xpath("//ul")
    end
    
  end
  
  describe "GET", :given => "a todo_item exists" do
    before(:each) do
      @response = request(resource(:todo_items))
    end
    
    it "has a list of todo_items" do
      pending
      @response.should have_xpath("//ul/li")
    end
  end
  
  describe "a successful POST" do
    before(:each) do
      TodoItem.all.destroy!
      @response = request(resource(:todo_items), :method => "POST", 
        :params => { :todo_item => { :id => nil }})
    end
    
    it "redirects to resource(:todo_items)" do
      @response.should redirect_to(resource(TodoItem.first), :message => {:notice => "todo_item was successfully created"})
    end
    
  end
end

describe "resource(@todo_item)" do 
  describe "a successful DELETE", :given => "a todo_item exists" do
     before(:each) do
       @response = request(resource(TodoItem.first), :method => "DELETE")
     end

     it "should redirect to the index action" do
       @response.should redirect_to(resource(:todo_items))
     end

   end
end

describe "resource(:todo_items, :new)" do
  before(:each) do
    @response = request(resource(:todo_items, :new))
  end
  
  it "responds successfully" do
    @response.should be_successful
  end
end

describe "resource(@todo_item, :edit)", :given => "a todo_item exists" do
  before(:each) do
    @response = request(resource(TodoItem.first, :edit))
  end
  
  it "responds successfully" do
    @response.should be_successful
  end
end

describe "resource(@todo_item)", :given => "a todo_item exists" do
  
  describe "GET" do
    before(:each) do
      @response = request(resource(TodoItem.first))
    end
  
    it "responds successfully" do
      @response.should be_successful
    end
  end
  
  describe "PUT" do
    before(:each) do
      @todo_item = TodoItem.first
      @response = request(resource(@todo_item), :method => "PUT", 
        :params => { :todo_item => {:id => @todo_item.id} })
    end
  
    it "redirect to the article show action" do
      @response.should redirect_to(resource(@todo_item))
    end
  end
  
end

