Feature: Listing tasks
	As a time-manager
  In order to browse my tasks
  I want to view list of my tasks

  Scenario: list tasks
  	Given following tasks exists:
      | Тестовая задача 1 | Описание	|
      | Тестовая задача 2 | Описание  |
    When I run command `list`
    #match
    Then I should look something like this
    	"""
    	#2	Тестовая задача 2	(\d){4}-(\d){2}-(\d){2}
    	#1	Тестовая задача 1	(\d){4}-(\d){2}-(\d){2}
    	"""