Feature: Manage users and their teams/projects.
  In order to manage users with their teams and projects
  As a client software developer
  I need to be able to create, retrieve, update them through the API.

  @createSchema
  Scenario: Create a customer for the team and project
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

  Scenario: Create a team for the user
    When I add "Content-Type" header equal to "application/ld+json"
    And I add "Accept" header equal to "application/ld+json"
    And I send a "POST" request to "/teams" with body:
    """
    {
      "name": "US-Team",
      "status": 1,
      "customer": "/customers/1"
    }
    """
    Then the response status code should be 201
    And the response should be in JSON
    And the header "Content-Type" should be equal to "application/ld+json; charset=utf-8"
    And the JSON should be equal to:
    """
    {
      "@context": "/contexts/Team",
      "@id": "/teams/1",
      "@type": "Team",
      "id": 1,
      "name": "US-Team",
      "status": 1,
      "customer": "/customers/1",
      "users": []
    }
    """

  Scenario: Create a project for the user
    When I add "Content-Type" header equal to "application/ld+json"
    And I add "Accept" header equal to "application/ld+json"
    And I send a "POST" request to "/projects" with body:
    """
    {
      "name": "Glasses",
      "url": "http://example.com/board/Glasses",
      "status": 1,
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
      "status": 1,
      "customer": "/customers/1",
      "tasks": [],
      "users": []
    }
    """

  Scenario: Create another project for the user
    When I add "Content-Type" header equal to "application/ld+json"
    And I add "Accept" header equal to "application/ld+json"
    And I send a "POST" request to "/projects" with body:
    """
    {
      "name": "Scooby",
      "url": "http://example.com/board/Scooby",
      "status": 1,
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
      "@id": "/projects/2",
      "@type": "Project",
      "id": 2,
      "name": "Scooby",
      "url": "http://example.com/board/Scooby",
      "status": 1,
      "customer": "/customers/1",
      "tasks": [],
      "users": []
    }
    """

  Scenario: Create a User
    When I add "Content-Type" header equal to "application/ld+json"
    And I add "Accept" header equal to "application/ld+json"
    And I send a "POST" request to "/users" with body:
    """
    {
      "name": "Juan Perez",
      "email": "jperez@example.com",
      "status": 1,
      "team": "/teams/1",
      "projects": [
        "/projects/1"
      ]
    }
    """
    Then the response status code should be 201
    And the response should be in JSON
    And the header "Content-Type" should be equal to "application/ld+json; charset=utf-8"
    And the JSON should be equal to:
    """
    {
      "@context": "/contexts/User",
      "@id": "/users/1",
      "@type": "User",
      "id": 1,
      "name": "Juan Perez",
      "email": "jperez@example.com",
      "status": 1,
      "team": "/teams/1",
      "projects": [
        "/projects/1"
      ]
    }
    """

  Scenario: Retrieve a User
    When I add "Accept" header equal to "application/ld+json"
    And I send a "GET" request to "/users/1"
    Then the response status code should be 200
    And the response should be in JSON
    And the header "Content-Type" should be equal to "application/ld+json; charset=utf-8"
    And the JSON should be equal to:
    """
    {
      "@context": "/contexts/User",
      "@id": "/users/1",
      "@type": "User",
      "id": 1,
      "name": "Juan Perez",
      "email": "jperez@example.com",
      "status": 1,
      "team": "/teams/1",
      "projects": [
        "/projects/1"
      ]
    }
    """

  Scenario: Retrieve the user list
    When I add "Accept" header equal to "application/ld+json"
    And I send a "GET" request to "/users"
    Then the response status code should be 200
    And the response should be in JSON
    And the header "Content-Type" should be equal to "application/ld+json; charset=utf-8"
    And the JSON should be equal to:
    """
    {
      "@context": "/contexts/User",
      "@id": "/users",
      "@type": "hydra:Collection",
      "hydra:member": [
        {
          "@id": "/users/1",
          "@type": "User",
          "id": 1,
          "name": "Juan Perez",
          "email": "jperez@example.com",
          "status": 1,
          "team": "/teams/1",
          "projects": [
            "/projects/1"
          ]
        }
      ],
      "hydra:totalItems": 1
    }
    """

  Scenario: Update the name of a user
    When I add "Content-Type" header equal to "application/ld+json"
    And I add "Accept" header equal to "application/ld+json"
    And I send a "PUT" request to "/users/1" with body:
    """
    {
      "name": "Juana Perez"
    }
    """
    Then the response status code should be 200
    And the response should be in JSON
    And the header "Content-Type" should be equal to "application/ld+json; charset=utf-8"
    And the JSON should be equal to:
    """
    {
      "@context": "/contexts/User",
      "@id": "/users/1",
      "@type": "User",
      "id": 1,
      "name": "Juana Perez",
      "email": "jperez@example.com",
      "status": 1,
      "team": "/teams/1",
      "projects": [
        "/projects/1"
      ]
    }
    """

  Scenario: Add a project to an existing user
    When I add "Content-Type" header equal to "application/ld+json"
    And I add "Accept" header equal to "application/ld+json"
    And I send a "PUT" request to "/users/1" with body:
    """
    {
      "projects": [
        "/projects/1",
        "/projects/2"
      ]
    }
    """
    Then the response status code should be 200
    And the response should be in JSON
    And the header "Content-Type" should be equal to "application/ld+json; charset=utf-8"
    And the JSON should be equal to:
    """
    {
      "@context": "/contexts/User",
      "@id": "/users/1",
      "@type": "User",
      "id": 1,
      "name": "Juana Perez",
      "email": "jperez@example.com",
      "status": 1,
      "team": "/teams/1",
      "projects": [
        "/projects/1",
        "/projects/2"
      ]
    }
    """

  Scenario: Remove a project to an existing user
    When I add "Content-Type" header equal to "application/ld+json"
    And I add "Accept" header equal to "application/ld+json"
    And I send a "PUT" request to "/users/1" with body:
    """
    {
      "projects": [
        "/projects/2"
      ]
    }
    """
    Then the response status code should be 200
    And the response should be in JSON
    And the header "Content-Type" should be equal to "application/ld+json; charset=utf-8"
    And the JSON should be equal to:
    """
    {
      "@context": "/contexts/User",
      "@id": "/users/1",
      "@type": "User",
      "id": 1,
      "name": "Juana Perez",
      "email": "jperez@example.com",
      "status": 1,
      "team": "/teams/1",
      "projects": {
        "1": "/projects/2"
      }
    }
    """

  Scenario: Throw errors when a create a User with an existing email.
    When I add "Content-Type" header equal to "application/ld+json"
    And I add "Accept" header equal to "application/ld+json"
    And I send a "POST" request to "/users" with body:
    """
    {
      "name": "Jose Perez",
      "email": "jperez@example.com",
      "status": 1,
      "team": "/teams/1",
      "projects": [
        "/projects/1"
      ]
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
      "hydra:description": "email: This value is already used.",
      "violations": [
        {
          "propertyPath": "email",
          "message": "This value is already used."
        }
      ]
    }
    """

  @dropSchema
  Scenario: Throw errors when update a User with an empty name.
    When I add "Content-Type" header equal to "application/ld+json"
    And I add "Accept" header equal to "application/ld+json"
    And I send a "PUT" request to "/users/1" with body:
    """
    {
      "name": ""
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
