Feature: Show info about task
	As a time-manager
	In order to learn my activity with specific task
	I want to view details about task and its notes

	Background:
    Given following tasks exists:
      | title               | description  | created_at | 
      | Тестовая задача 1   | Описание     | 1415812561 |

	Scenario: view task info
		When I run command `-t 1`
		Then I should see
		"""
		#1 "Тестовая задача 1"
		Описание
		"""