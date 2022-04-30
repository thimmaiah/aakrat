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
  	|roles                |company                       |user                                 |msg	|
    |team_member   	      |company_type=Architect        |first_name=Tim;email=m2@gmail.com    |A message with a confirmation link has been sent to your email address.|
    |team_member  	      |company_type=Architect        |first_name=Tim;email=m2@gmail.com    |A message with a confirmation link has been sent to your email address.|
  