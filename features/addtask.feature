Feature: Adding task
	As a time-manager
  In order to group my activity
  I want to add a task

  Scenario: Successfully add task
    #Given I command to add task
    #When I type a task title "Тестовая здача"
    #And I type a task description "Описание тестовой задачи"
    #Then I should see "Задача \"Тестовая задача\" (#1) добавлена"
    When I run command `add`
    And I type a task title "Тестовая задача"
    And I type a task description "Описание тестовой задачи"
    Then I should see "Задача 'Тестовая задача' (#1) добавлена"