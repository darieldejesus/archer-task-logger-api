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

  Scenario: Create a project
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

  Scenario: Retrieve a project
    When I add "Accept" header equal to "application/ld+json"
    And I send a "GET" request to "/projects/1"
    Then the response status code should be 200
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

  Scenario: Retrieve the project list
    When I add "Accept" header equal to "application/ld+json"
    And I send a "GET" request to "/projects"
    Then the response status code should be 200
    And the response should be in JSON
    And the header "Content-Type" should be equal to "application/ld+json; charset=utf-8"
    And the JSON should be equal to:
    """
    {
      "@context": "/contexts/Project",
      "@id": "/projects",
      "@type": "hydra:Collection",
      "hydra:member": [
        {
          "@id": "/projects/1",
          "@type": "Project",
          "id": 1,
          "name": "Glasses",
          "url": "http://example.com/board/Glasses",
          "status": 2,
          "customer": "/customers/1",
          "tasks": []
        }
      ],
      "hydra:totalItems": 1
    }
    """
  
  Scenario: Update a project
    When I add "Content-Type" header equal to "application/ld+json"
    And I add "Accept" header equal to "application/ld+json"
    And I send a "PUT" request to "/projects/1" with body:
    """
    {
      "status": 0
    }
    """
    Then the response status code should be 200
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
      "status": 0,
      "customer": "/customers/1",
      "tasks": []
    }
    """

  @dropSchema
  Scenario: Throw errors when a POST request is invalid (Empty name).
    When I add "Content-Type" header equal to "application/ld+json"
    And I add "Accept" header equal to "application/ld+json"
    And I send a "POST" request to "/projects" with body:
    """
    {
      "name": "",
      "url": "http://example.com/board/Glasses",
      "status": 2,
      "customer": "/customers/1"
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
