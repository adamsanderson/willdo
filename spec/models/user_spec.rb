require File.join( File.dirname(__FILE__), '..', "spec_helper" )

describe User do
  after{
    DataMapper::AutoMigrator.auto_migrate
  }
  
  it "returns the same name as the login" do
    user = User.gen
    user.name.should == user.login
  end
  
  it "must have a confirmed password" do
    user = User.gen
    user.valid?.should be_true
    
    password = 'oh_pie!'
    user.password = password
    user.valid?.should be_false
    
    user.password_confirmation = password
    user.valid?.should be_true
  end

end