Feature: Manage the list of projects

  In order to keep tracks and manage of all my projects
  As a Tracks user
  I want to manage my list of projects

  Background:
    Given the following user record
      | login    | password | is_admin |
      | testuser | secret   | false    |
    And there exists a project "manage me" for user "testuser"
    And there exists a project "upgrade jquery" for user "testuser"
    And there exists a project "a project name starting with a" for user "testuser"
    And I have logged in as "testuser" with password "secret"

  Scenario: The list of project contain all projects
    When I go to the projects page
    Then I should see "manage me"
    And I should see "upgrade jquery"
    And the badge should show 3

  Scenario: Clicking on a project takes me to the project page
    When I go to the projects page
    And I follow "manage me"
    Then I should be on the "manage me" project page

  @selenium
  Scenario: Editing a project name will update the list
    When I go to the projects page
    And I edit the project name of "manage me" to "manage him"
    Then I should see "manage him"

  @selenium
  Scenario: Deleting a project will remove it from the list
    When I go to the projects page
    And I delete project "manage me"
    Then I should not see "manage me"
    And the badge should show 2
    And the project list badge for "active" projects should show 2

  @selenium
  Scenario: Changing project state will move project to other state list
    When I go to the projects page
    Then the project "manage me" should be in state list "active"
    And the project list badge for "active" projects should show 3
    When I edit the project state of "manage me" to "hidden"
    Then the project "manage me" should not be in state list "active"
    And the project "manage me" should be in state list "hidden"
    And the project list badge for "active" projects should show 2
    And the project list badge for "hidden" projects should show 1

  @selenium
  Scenario: Dragging a project to change list order of projects
    When I go to the projects page
    Then the project "manage me" should be above the project "upgrade jquery"
    When I drag the project "manage me" below "upgrade jquery"
    Then the project "upgrade jquery" should be above the project "manage me"

  @selenium
  Scenario: Hiding and unhiding the new project form
    When I go to the projects page
    Then the new project form should be visible
    When I follow "« Hide form"
    Then the new project form should not be visible
    When I follow "Create a new project »"
    Then the new project form should be visible

  @selenium
  Scenario: Adding a new project
    When I go to the projects page
    And I submit a new project with name "finish cucumber tests"
    Then I should see "finish cucumber tests"
    And the badge should show 4
    And the project list badge for "active" projects should show 4

  @selenium
  Scenario: Adding a new project and take me to the project page
    When I go to the projects page
    And I submit a new project with name "finish cucumber tests" and select take me to the project
    Then I should be on the "finish cucumber tests" project page

  @selenium, @wip
  Scenario: Sorting the project alphabetically
    When I go to the projects page
    Then the project "manage me" should be above the project "a project name starting with a"
    When I sort the list alphabetically
    Then the project "a project name starting with a" should be above the project "manage me"

  @selenium, @wip
  Scenario: Sorting the project by number of task
    Given I have a project "test" with 2 todos
    When I go to the projects page
    Then the project "manage me" should be above the project "test"
    When I sort the list by number of tasks
    Then the project "test" should be above the project "manage me"
