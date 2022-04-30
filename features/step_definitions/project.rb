    include CurrencyHelper
    include ActionView::Helpers::TranslationHelper

    Given('the company has {int} clients') do |count|
      (1..count.to_i).each do 
        client = FactoryBot.create(:client, company: @company, user_type: "Client")
        puts "\n####Client####\n"
        puts client.to_json
      end
    end
    
    When('I create a new project {string}') do |args|
        @new_project = FactoryBot.build(:project)
        key_values(@new_project, args)
        click_on("New Project")
        select(@new_project.client.full_name, from: "project_client_id")
        fill_in('project_name', with: @new_project.name)
        fill_in('project_start_date', with: @new_project.start_date)
        fill_in('project_end_date', with: @new_project.end_date)
        fill_in('project_client_estimated_budget', with: @new_project.client_estimated_budget)

        fill_in('project_estimated_builtup_area', with: @new_project.estimated_builtup_area)
        fill_in('project_actual_builtup_area', with: @new_project.actual_builtup_area)
        fill_in('project_percentage_of_estimated_budget', with: @new_project.percentage_of_estimated_budget)
        select(@new_project.status, from: "project_status")


        click_on("Save")
    end
      
    Given('I am at the projects page') do
      visit("/projects")
      puts @user.reload.roles.to_json
    end
    
    Then('an project should be created') do
        @project = Project.last
        @project.name.should == @new_project.name
        @project.client_id.should == @new_project.client_id
        @project.start_date.should == @new_project.start_date
        @project.end_date.should == @new_project.end_date
        @project.client_estimated_budget.should == @new_project.client_estimated_budget
        @project.estimated_builtup_area.should == @new_project.estimated_builtup_area
        @project.actual_builtup_area.should == @new_project.actual_builtup_area
        @project.percentage_of_estimated_budget.should == @new_project.percentage_of_estimated_budget
        @project.status.should == @new_project.status
    end
    
    Then('I should see the project details on the details page') do
        expect(page).to have_content(@new_project.name)
        expect(page).to have_content(@new_project.client.full_name)
        expect(page).to have_content(l @new_project.start_date)
        expect(page).to have_content(l @new_project.end_date)
        expect(page).to have_content(money_to_currency @new_project.client_estimated_budget)
        expect(page).to have_content(@new_project.estimated_builtup_area)
        expect(page).to have_content(@new_project.actual_builtup_area)
        expect(page).to have_content(@new_project.percentage_of_estimated_budget)
        expect(page).to have_content(@new_project.status)
    end
    
    Then('I should see the project in all projects page') do
        visit("/projects")
        expect(page).to have_content(@new_project.name)
        expect(page).to have_content(@new_project.client.full_name)
        expect(page).to have_content(l @new_project.start_date)
        expect(page).to have_content(l @new_project.end_date)
        expect(page).to have_content(money_to_currency @new_project.client_estimated_budget)
        expect(page).to have_content(@new_project.percentage_of_estimated_budget)
        expect(page).to have_content(@new_project.status)
    end
    