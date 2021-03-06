WillDo
======

WillDo is a very simple RESTful application.  It is meant to be the base layer for various
explorations into building alternative front-end clients.  As such, WillDo's HTML interface
is little more than some basic scaffolding required to explore the data.

WillDo is just complicated enough to ensure that clients will represent real world clients,
however is not so complex that it should be a burden.

This is an open project, and it would be awesome to see some folks fork it and build more
example clients. 

Design Principles
-----------------

No JavaScript was used for the interface, real clients will provide their own interface, so
we should not add any more to the UI layer than is needed.

Resources are used whenever they make sense.  Everything that can be, should be mapped as a
resource.  This way we can keep a simple interface to the underlying data.

Each resource should be available in multiple formats.  We should facilitate as many clients
as possible, if people enjoy XML, give them XML, if they want JSON, then give them JSON.

File Structure
--------------

WillDo is a standard Merb application.  Clients and shared libraries will exist in the +public+ directory.

For instance:

  - public/
    - clients/
      - jQuery_client/
        - index.html
        - client.js
      - shoes_client/
        - will_do.shy
    - lib
      - JSON2.js 

Resource Structure
------------------

WillDo consists of three key resources: Users, TodoLists, and TodoItems.
Users have many TodoLists, and TodoLists have many TodoItems.

Resources are accessible via nested routes such as:

get User id 1:
>  /users/1

get the TodoLists for User 1:
>  /users/1/todo_lists
  
get the TodoItems for TodoList 1:
>  /users/1/todo_lists/1/todo_items
  
More Information
This project is motivated by my post here: http://endofline.wordpress.com/2008/12/01/the-new-client-side-restful-backends/

Warnings, Dire Words, Utter Failures
------------------------------------

At the moment, the app works, however the tests don't.  To be quite honest, a lot seems to have changed in Merb's
progression to 1.0 status, and I'm having a lot of trouble figuring out how to write meaningful tests.

Contact
-------
Adam Sanderson, netghost@gmail.com