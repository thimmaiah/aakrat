Feature: User
  Can create and view a user as a startup

Scenario Outline: Create new user
  Given Im logged in as a user "" for an company "company_type=Architect"
  Given I have the role "team_lead"
  Given the company has 3 clients
  And I am at the projects page
  When I create a new project "<project>"
  Then I should see the "<msg>"
  And an project should be created
  And I should see the project details on the details page
  And I should see the project in all projects page
  
  Examples:
  	|project                                                       |msg	|
    |name=Farm House;client_estimated_budget_cents=1000000         |Project was successfully created|
    |name=Industrial Shed;client_estimated_budget_cents=2000000    |Project was successfully created|
  