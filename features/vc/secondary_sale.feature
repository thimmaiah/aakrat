Feature: Secondary Sale
  Can view a sale as a VC

Scenario Outline: View sale - not externally visible
  Given there is a user "<user>" for an company "<company>"
  Given there is a sale "<sale>"
  Given Im logged in as a user "first_name=Emp1" for an company "company_type=VC"
  Given my firm is an investor in the startup
  And I should not see the sale in all sales page
  And I should not see the sale details on the details page

  Examples:
  	|user	    |company               |sale             |msg	|
  	|  	        |company_type=Architect  |name=Grand Sale  |Secondary sale was successfully created|
    |  	        |company_type=Architect  |name=Winter Sale |Secondary sale was successfully created|



Scenario Outline: View sale - externally visible, but no access
  Given there is a user "<user>" for an company "<company>"
  Given there is a sale "<sale>"
  Given Im logged in as a user "first_name=Emp1" for an company "company_type=VC"
  Given my firm is an investor in the startup
  And I should not see the sale in all sales page
  And I should not see the sale details on the details page

  Examples:
  	|user	    |company               |sale                                     |msg	|
  	|  	        |company_type=Architect  |name=Grand Sale;visible_externally=true  |Secondary sale was successfully created|
    |  	        |company_type=Architect  |name=Winter Sale;visible_externally=true |Secondary sale was successfully created|

Scenario Outline: View sale - externally visible, with access
  Given there is a user "<user>" for an company "<company>"
  Given there is a sale "<sale>"
  Given Im logged in as a user "first_name=Emp1" for an company "company_type=VC"
  Given my firm is an investor in the startup
  And the investor has access rights to the sale
  And I should see the sale in all sales page
  And I should see the sale details on the details page

  Examples:
  	|user	    |company               |sale                                     |msg	|
  	|  	        |company_type=Architect  |name=Grand Sale;visible_externally=true  |Secondary sale was successfully created|
    |  	        |company_type=Architect  |name=Winter Sale;visible_externally=true |Secondary sale was successfully created|


Scenario Outline: View sale - make offer
  Given there is a user "<user>" for an company "<company>"
  Given there is a FundingRound "name=Series A"
  Given there is a sale "<sale>"
  Given Im logged in as a user "first_name=Emp1" for an company "company_type=VC"
  Given my firm is an investor in the startup
  Given there are "2" investments "" in the startup
  And the investor has access rights to the sale
  And I should see the sale details on the details page
  And I should see my holdings in the holdings tab
  And when I make an offer for my holdings
  Then I should see the offer 
  And the sale offer amount must not be updated
  And when the offer is approved
  Then the sale offer amount must be updated
  

  Examples:
  	|user	    |company               |sale                                     |msg	|
  	|  	        |company_type=Architect  |name=Grand Sale;visible_externally=true  |Secondary sale was successfully created|
    |  	        |company_type=Architect  |name=Winter Sale;visible_externally=true |Secondary sale was successfully created|
