@qtype @qtype_algebra
Feature: Preview a Short answer question
  As a teacher
  In order to check my Short answer questions will work for students
  I need to preview them

  Background:
    Given the following "users" exist:
      | username | firstname | lastname | email               |
      | teacher1 | T1        | Teacher1 | teacher1@moodle.com |
    And the following "courses" exist:
      | fullname | shortname | category |
      | Course 1 | C1        | 0        |
    And the following "course enrolments" exist:
      | user     | course | role           |
      | teacher1 | C1     | editingteacher |
    And the following "question categories" exist:
      | contextlevel | reference | name           |
      | Course       | C1        | Test questions |
    And the following "questions" exist:
      | questioncategory | qtype     | name        | template   |
      | Test questions   | algebra   | algebra-001 | simplemath |
    Given I log in as "teacher1"
    And I am on "Course 1" course homepage
    And I navigate to "Question bank" node in "Course administration"

  @javascript @_switch_window
  Scenario: Preview an Algebra question with correct answer
    When I click on "Preview" "link" in the "algebra-001" "table_row"
    And I switch to "questionpreview" window
    Then I should see "P(x) = 3x and Q(x) = 4x. Calculate (P + Q)(x)"
    # Set behaviour options
    And I set the following fields to these values:
      | behaviour | immediatefeedback |
    And I press "Start again with these options"
    And I set the field with xpath "//div[@class='qtext']//input[contains(@id, '1_answer')]" to "7*x"
    And I press "Check"
    Then I should see "This is a very good answer."
    And I should see "Generalfeedback: (P + Q)(x) = 7x."
    And I should see "The correct answer is: 7*x"

  @javascript @_switch_window
  Scenario: Preview an Algebra question with incorrect answer
    When I click on "Preview" "link" in the "algebra-001" "table_row"
    And I switch to "questionpreview" window
    Then I should see "P(x) = 3x and Q(x) = 4x. Calculate (P + Q)(x)"
    # Set behaviour options
    And I set the following fields to these values:
      | behaviour | immediatefeedback |
    And I press "Start again with these options"
    And I set the field with xpath "//div[@class='qtext']//input[contains(@id, '1_answer')]" to "6*x"
    And I press "Check"
    Then I should see "That is a bad answer."
    And I should see "Generalfeedback: (P + Q)(x) = 7x."
    And I should see "The correct answer is: 7*x"