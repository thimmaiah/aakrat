Feature: Registration
  Registration should work properly

Scenario Outline: User Registration Successfully
  Given there is an unsaved user "<user>" for an company "<company>"
  And I am at the registration page
  When I fill and submit the registration page
  Then I should see the "<msg1>"
  Then when I click the confirmation link
  Then I should see the "Your email address has been successfully confirmed."
  Then the user should be confirmed
  Examples:
  	|user		|company             |msg1											                                              |msg2		  |
  	| 	    |company_type=VC     |A message with a confirmation link has been sent to your email address.	|Signed in successfully	|
    |       |company_type=Startup|A message with a confirmation link has been sent to your email address. |Signed in successfully  |
    | 	    |company_type=VC     |A message with a confirmation link has been sent to your email address.	|Signed in successfully	|



Scenario Outline: User Registration Successfully
  Given there is a user "<user>" for an company "<company>"
  Then the user should have the roles "<roles>"
  Examples:
  	|user		|company               |roles		|	
  	| 	    |company_type=VC       |employee,investor,secondary_buyer	|
    |       |company_type=Startup  |employee,startup   |
    | 	    |company_type=Holding  |employee,holding   |
    | 	    |company_type=Advisor  |employee,secondary_buyer   |
    | 	    |company_type=Family Office  |employee,secondary_buyer   |

