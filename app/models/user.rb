require 'merb-auth-more/mixins/salted_user'

# This is a default user class used to activate merb-auth.  Feel free to change from a User to 
# Some other class, or to remove it altogether.  If removed, merb-auth may not work by default.
#
# Don't forget that by default the salted_user mixin is used from merb-more
# You'll need to setup your db as per the salted_user mixin, and you'll need
# To use :password, and :password_confirmation when creating a user
#
# see merb/merb-auth/setup.rb to see how to disable the salted_user mixin
# 
# You will need to setup your database and create a user.
class User
  include DataMapper::Resource
  include DataMapper::Serialize
  include Merb::Authentication::Mixins::SaltedUser
  
  property :id,    Serial
  property :email, String, :format=>:email_address
  property :login, String, :nullable=>false
  
  validates_is_unique :email, :login
  has n, :todo_lists
  
  def name
    login
  end
  
protected
  # In future versions of datamapper, this will be possible, for
  # now we just have to be careful in the controllers.
  #
  # def properties_to_serialize(opts)
  #   excluded_properties = Array(options[:exclude])
  #   excluded_properties << :crypted_password
  #   excluded_properties << :salt
  #   super(options.merge(:exclude=>excluded_properties.uniq))
  # end
end
