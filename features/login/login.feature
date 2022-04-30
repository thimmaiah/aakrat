Feature: Login
  Login should be allowed only if there are valid credentials

Scenario Outline: Login Successfully
  Given there is a user "<user>" for an company "<company>"
  And I am at the login page
  When I fill and submit the login page
  Then I should see the "<msg>"

  Examples:
  	|user	              |company                 |msg	|
  	|  	                |company_type=Architect  |Signed in successfully|
    |  	                |company_type=Architect  |Signed in successfully|
    |accept_terms=false |company_type=Architect  |Please accept the Terms and Conditions|
    |system_created=true|company_type=Architect  |Please change your password at the earliest|

Scenario Outline: Login Successfully
  Given there is a user "<user>"
  And I am at the login page
  When I fill and submit the login page
  Then I should see the "<msg>"

  Examples:
  	|user	  |msg	|
  	|  	    |Signed in successfully|
    |  	    |Signed in successfully|


Scenario Outline: Login Incorrectly
  Given there is a user "<user>"
  And I am at the login page
  When I fill the password incorrectly and submit the login page
  Then I should see the "<msg>"

  Examples:
  	|user		|msg	|
  	|	      |Invalid Email or password|
    
