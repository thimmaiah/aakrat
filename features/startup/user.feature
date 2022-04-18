Feature: User
  Can create and view a user as a startup

Scenario Outline: Create new user
  Given Im logged in as a user "" for an company "<company>"
  And I am at the users page
  When I create a new user "<user>"
  Then I should see the "<msg>"
  And an user should be created
  And I should see the user details on the details page
  And I should see the user in all users page
  And the created user should have the roles "<roles>"

  Examples:
  	|roles                      	    |company                     |user                                 |msg	|
  	|employee,investor,secondary_buyer	|company_type=VC             |first_name=Mohith;email=m1@gmail.com |A message with a confirmation link has been sent to your email address.|
    |employee,startup   	            |company_type=Startup        |first_name=Tim;email=m2@gmail.com    |A message with a confirmation link has been sent to your email address.|
    |employee,secondary_buyer  	        |company_type=Advisor        |first_name=Tim;email=m2@gmail.com    |A message with a confirmation link has been sent to your email address.|
    |employee,secondary_buyer  	        |company_type=Family Office  |first_name=Tim;email=m2@gmail.com    |A message with a confirmation link has been sent to your email address.|
    |employee,holding         	        |company_type=Holding        |first_name=Tim;email=m2@gmail.com    |A message with a confirmation link has been sent to your email address.|
