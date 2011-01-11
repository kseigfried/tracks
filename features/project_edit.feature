Feature: Edit a project
  In order to reach a goal by doing several related todos
  As a Tracks user
  I want to manage these todos in a project

  Background:
    Given the following user record
      | login    | password | is_admin |
      | testuser | secret   | false    |
    And there exists a project "manage me" for user "testuser"
    And I have logged in as "testuser" with password "secret"

  @selenium
  Scenario: I can describe the project using markup
    When I visit the "manage me" project
    And I edit the project description to "_successfull outcome_: project is *done*"
    Then I should see the italic text "successfull outcome" in the project description
    And I should see the bold text "done" in the project description

  # Ticket #1043
  @selenium @wip
  Scenario: I can move a todo out of the current project
    Given I have a project "foo" with 2 todos
    When I visit the "foo" project
    And I change the project_name field of "Todo 1" to "bar"
    Then I should not see the todo "Todo 1"
    And I should see the todo "Todo 2"

  @selenium
  Scenario: I can edit the project name in place
    Given I have a project "release tracks 1.8" with 1 todos
    When I visit the project page for "release tracks 1.8"
    And I edit the project name in place to be "release tracks 2.0"
    Then I should see the project name is "release tracks 2.0"
    When I go to the projects page
    Then I should see that a project named "release tracks 1.8" is not present
    And I should see that a project named "release tracks 2.0" is present

  # Ticket #1041
  @selenium
  Scenario: I can change the name of the project using the Edit Project Settings form
    Given I have a project "bananas" with 1 todos
    When I visit the "bananas" project
    And I edit the project name to "cherries"
    Then the project title should be "cherries"

  # Ticket #1042
  @selenium
  Scenario: I cannot change the name of a project in the project view to the name of another existing project
    Given I have a project "test" with 1 todos
    When I go to the projects page
    Then the badge should show 2   # "manage me" and "test"
    When I visit the "manage me" project
    And I try to edit the project name to "test"
    Then I should see "Name already exists"

  # Ticket #1042
  @selenium
  Scenario: I cannot change the name of a project in the project list view to the name of another existing project
    Given I have a project "test" with 1 todos
    When I go to the projects page
    Then the badge should show 2   # "manage me" and "test"
    When I try to edit the project name of "manage me" to "test"
    Then I should see "Name already exists"
