Feature: Manage projects and their customers.
  In order to manage projects along with their customers
  As a client software developer
  I need to be able to create, retrieve, update them through the API.

  @createSchema
  Scenario: Create a customer for the project
    When I add "Content-Type" header equal to "application/ld+json"
    And I add "Accept" header equal to "application/ld+json"
    And I send a "POST" request to "/customers" with body:
    """
    {
      "name": "Alphabet Inc",
      "description": "A big company",
      "status": 1
    }
    """
    Then the response status code should be 201
    And the response should be in JSON
    And the header "Content-Type" should be equal to "application/ld+json; charset=utf-8"
    And the JSON should be equal to:
    """
    {
      "@context": "/contexts/Customer",
      "@id": "/customers/1",
      "@type": "Customer",
      "id": 1,
      "name": "Alphabet Inc",
      "description": "A big company",
      "status": 1,
      "projects": [],
      "teams": []
    }
    """

  Scenario: Create a project for the task
    When I add "Content-Type" header equal to "application/ld+json"
    And I add "Accept" header equal to "application/ld+json"
    And I send a "POST" request to "/projects" with body:
    """
    {
      "name": "Glasses",
      "url": "http://example.com/board/Glasses",
      "status": 2,
      "customer": "/customers/1"
    }
    """
    Then the response status code should be 201
    And the response should be in JSON
    And the header "Content-Type" should be equal to "application/ld+json; charset=utf-8"
    And the JSON should be equal to:
    """
    {
      "@context": "/contexts/Project",
      "@id": "/projects/1",
      "@type": "Project",
      "id": 1,
      "name": "Glasses",
      "url": "http://example.com/board/Glasses",
      "status": 2,
      "customer": "/customers/1",
      "tasks": []
    }
    """

  Scenario: Create a task
    When I add "Content-Type" header equal to "application/ld+json"
    And I add "Accept" header equal to "application/ld+json"
    And I send a "POST" request to "/tasks" with body:
    """
    {
      "name": "Task-1",
      "url": "http://example.com/board/Glasses/Task-1",
      "status": 1,
      "project": "/projects/1"
    }
    """
    Then the response status code should be 201
    And the response should be in JSON
    And the header "Content-Type" should be equal to "application/ld+json; charset=utf-8"
    And the JSON should be equal to:
    """
    {
      "@context": "/contexts/Task",
      "@id": "/tasks/1",
      "@type": "Task",
      "id": 1,
      "name": "Task-1",
      "url": "http://example.com/board/Glasses/Task-1",
      "status": 1,
      "project": "/projects/1"
    }
    """

  Scenario: Retrieve a task
    When I add "Accept" header equal to "application/ld+json"
    And I send a "GET" request to "/tasks/1"
    Then the response status code should be 200
    And the response should be in JSON
    And the header "Content-Type" should be equal to "application/ld+json; charset=utf-8"
    And the JSON should be equal to:
    """
    {
      "@context": "/contexts/Task",
      "@id": "/tasks/1",
      "@type": "Task",
      "id": 1,
      "name": "Task-1",
      "url": "http://example.com/board/Glasses/Task-1",
      "status": 1,
      "project": "/projects/1"
    }
    """

  Scenario: Retrieve the task list
    When I add "Accept" header equal to "application/ld+json"
    And I send a "GET" request to "/tasks"
    Then the response status code should be 200
    And the response should be in JSON
    And the header "Content-Type" should be equal to "application/ld+json; charset=utf-8"
    And the JSON should be equal to:
    """
    {
      "@context": "/contexts/Task",
      "@id": "/tasks",
      "@type": "hydra:Collection",
      "hydra:member": [
        {
          "@id": "/tasks/1",
          "@type": "Task",
          "id": 1,
          "name": "Task-1",
          "url": "http://example.com/board/Glasses/Task-1",
          "status": 1,
          "project": "/projects/1"
        }
      ],
      "hydra:totalItems": 1
    }
    """
  
  Scenario: Update a task
    When I add "Content-Type" header equal to "application/ld+json"
    And I add "Accept" header equal to "application/ld+json"
    And I send a "PUT" request to "/tasks/1" with body:
    """
    {
      "name": "T-1"
    }
    """
    Then the response status code should be 200
    And the response should be in JSON
    And the header "Content-Type" should be equal to "application/ld+json; charset=utf-8"
    And the JSON should be equal to:
    """
    {
      "@context": "/contexts/Task",
      "@id": "/tasks/1",
      "@type": "Task",
      "id": 1,
      "name": "T-1",
      "url": "http://example.com/board/Glasses/Task-1",
      "status": 1,
      "project": "/projects/1"
    }
    """

  @dropSchema
  Scenario: Throw errors when a POST request is invalid (Empty name).
    When I add "Content-Type" header equal to "application/ld+json"
    And I add "Accept" header equal to "application/ld+json"
    And I send a "POST" request to "/tasks" with body:
    """
    {
      "name": "",
      "url": "http://example.com/board/Glasses/Task-1",
      "status": 2,
      "project": "/projects/1"
    }
    """
    Then the response status code should be 400
    And the response should be in JSON
    And the header "Content-Type" should be equal to "application/ld+json; charset=utf-8"
    And the JSON should be equal to:
    """
    {
      "@context": "/contexts/ConstraintViolationList",
      "@type": "ConstraintViolationList",
      "hydra:title": "An error occurred",
      "hydra:description": "name: This value should not be blank.",
      "violations": [
        {
          "propertyPath": "name",
          "message": "This value should not be blank."
        }
      ]
    }
    """
