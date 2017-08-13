Feature: Manage teams and their customers.
  In order to manage teams along with their customers
  As a client software developer
  I need to be able to create, retrieve, update them through the API.

  @createSchema
  Scenario: Create a customer for the team
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

  Scenario: Create a team
    When I add "Content-Type" header equal to "application/ld+json"
    And I add "Accept" header equal to "application/ld+json"
    And I send a "POST" request to "/teams" with body:
    """
    {
      "name": "DR-Team",
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
      "@context": "/contexts/Team",
      "@id": "/teams/1",
      "@type": "Team",
      "id": 1,
      "name": "DR-Team",
      "status": 2,
      "customer": "/customers/1",
      "users": []
    }
    """

  Scenario: Retrieve a team
    When I add "Accept" header equal to "application/ld+json"
    And I send a "GET" request to "/teams/1"
    Then the response status code should be 200
    And the response should be in JSON
    And the header "Content-Type" should be equal to "application/ld+json; charset=utf-8"
    And the JSON should be equal to:
    """
    {
      "@context": "/contexts/Team",
      "@id": "/teams/1",
      "@type": "Team",
      "id": 1,
      "name": "DR-Team",
      "status": 2,
      "customer": "/customers/1",
      "users": []
    }
    """

  Scenario: Retrieve the team list
    When I add "Accept" header equal to "application/ld+json"
    And I send a "GET" request to "/teams"
    Then the response status code should be 200
    And the response should be in JSON
    And the header "Content-Type" should be equal to "application/ld+json; charset=utf-8"
    And the JSON should be equal to:
    """
    {
      "@context": "/contexts/Team",
      "@id": "/teams",
      "@type": "hydra:Collection",
      "hydra:member": [
        {
          "@id": "/teams/1",
          "@type": "Team",
          "id": 1,
          "name": "DR-Team",
          "status": 2,
          "customer": "/customers/1",
          "users": []
        }
      ],
      "hydra:totalItems": 1
    }
    """
  
  Scenario: Update a team
    When I add "Content-Type" header equal to "application/ld+json"
    And I add "Accept" header equal to "application/ld+json"
    And I send a "PUT" request to "/teams/1" with body:
    """
    {
      "name": "DR-Team",
      "status": 0,
      "customer": "/customers/1"
    }
    """
    Then the response status code should be 200
    And the response should be in JSON
    And the header "Content-Type" should be equal to "application/ld+json; charset=utf-8"
    And the JSON should be equal to:
    """
    {
      "@context": "/contexts/Team",
      "@id": "/teams/1",
      "@type": "Team",
      "id": 1,
      "name": "DR-Team",
      "status": 0,
      "customer": "/customers/1",
      "users": []
    }
    """

  @dropSchema
  Scenario: Throw errors when a POST request is invalid (Empty name).
    When I add "Content-Type" header equal to "application/ld+json"
    And I add "Accept" header equal to "application/ld+json"
    And I send a "POST" request to "/teams" with body:
    """
    {
      "name": "",
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
