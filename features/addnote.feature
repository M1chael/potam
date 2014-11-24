Feature: Adding note
	As a time manager
	In order to fix my activity
	I want to add notes for specified task

	Background:
    Given following tasks exists:
      | title               | description  | created_at | 
      | Тестовая задача 1   | Описание     | 1415812561 |
      | Тестовая задача 2   | Описание     | 1415812566 |

  Scenario: Successfully add notes
    Given the date is "1415812566"
    When I run command `-t 2 add -n`
    And I type a note "Текст"
    Then I should see "Заметка к задаче #2 добавлена"
    When I run command `-t 2 list`
    Then I should see
    """
    #2 "Тестовая задача 2"
    2014-11-12
    Описание
    
    2014-11-12
    Текст
    """