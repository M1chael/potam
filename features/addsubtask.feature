Feature: Adding subtask
	As a time-manager
  In order to plan my activity
  I want to add a subtask
  
  Background:
    Given following tasks exists:
      | title               | description  | created_at | 
      | Тестовая задача 1   | Описание     | 1415812561 |
      | Тестовая задача 2   | Описание     | 1415812566 |

  Scenario: Successfully add tasks
    When I run command `-t 2 add`
    And I type a subtask title "Подзадача 1"
    Then I should see "Подзадача #1 к задаче #2 добавлена"

  #  Scenario: Add multiline descriptions for tasks