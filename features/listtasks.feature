# encoding: utf-8
Feature: Listing tasks
	As a time-manager
  In order to browse my tasks
  I want to view list of my tasks

  Scenario: list tasks
  	Given following tasks exists:
      | title             | description  | created_at | 
      | Тестовая задача 1 | Описание	   | 1415812561 |
      | Тестовая задача 2 | Описание     | 1415812566 |
    When I run command `list`
    #match
    Then I should see
    	"""
    	#2	Тестовая задача 2	2014-11-12
    	#1	Тестовая задача 1	2014-11-12
    	"""