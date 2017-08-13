Feature: Manage customers.
  In order to manage customers
  As a client software developer
  I need to be able to create, retrieve, update them through the API.

  @createSchema
  Scenario: Create a customer
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

  Scenario: Retrieve the customer list
    When I add "Accept" header equal to "application/ld+json"
    And I send a "GET" request to "/customers"
    Then the response status code should be 200
    And the response should be in JSON
    And the header "Content-Type" should be equal to "application/ld+json; charset=utf-8"
    And the JSON should be equal to:
    """
    {
      "@context": "/contexts/Customer",
      "@id": "/customers",
      "@type": "hydra:Collection",
      "hydra:member": [
        {
          "@id": "/customers/1",
          "@type": "Customer",
          "id": 1,
          "name": "Alphabet Inc",
          "description": "A big company",
          "status": 1,
          "projects": [],
          "teams": []
        }
      ],
      "hydra:totalItems": 1
    }
    """

  Scenario: Retrieve a customer
    When I add "Accept" header equal to "application/ld+json"
    And I send a "GET" request to "/customers/1"
    Then the response status code should be 200
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

  Scenario: Throw errors when a POST request is invalid (Empty name).
    When I add "Content-Type" header equal to "application/ld+json"
    And I add "Accept" header equal to "application/ld+json"
    And I send a "POST" request to "/customers" with body:
    """
    {
      "name": "",
      "description": "A big company",
      "status": 1
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

  Scenario: Throw errors when a POST request is invalid (Invalid status).
    When I add "Content-Type" header equal to "application/ld+json"
    And I add "Accept" header equal to "application/ld+json"
    And I send a "POST" request to "/customers" with body:
    """
    {
      "name": "Alphabet Inc",
      "description": "A big company",
      "status": 100
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
      "hydra:description": "status: This value should be 2 or less.",
      "violations": [
        {
          "propertyPath": "status",
          "message": "This value should be 2 or less."
        }
      ]
    }
    """

  Scenario: Update a customer.
    When I add "Content-Type" header equal to "application/ld+json"
    And I add "Accept" header equal to "application/ld+json"
    And I send a "PUT" request to "/customers/1" with body:
    """
    {
      "name": "Alphabet Inc.",
      "description": "A bigger company",
      "status": 0
    }
    """
    Then the response status code should be 200
    And the response should be in JSON
    And the header "Content-Type" should be equal to "application/ld+json; charset=utf-8"
    And the JSON should be equal to:
    """
    {
      "@context": "/contexts/Customer",
      "@id": "/customers/1",
      "@type": "Customer",
      "id": 1,
      "name": "Alphabet Inc.",
      "description": "A bigger company",
      "status": 0,
      "projects": [],
      "teams": []
    }
    """

  @dropSchema
  Scenario: Throw errors when a PUT request is invalid (Empty name and description).
    When I add "Content-Type" header equal to "application/ld+json"
    And I add "Accept" header equal to "application/ld+json"
    And I send a "PUT" request to "/customers/1" with body:
    """
    {
      "name": "",
      "description": "",
      "status": 0
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
      "hydra:description": "name: This value should not be blank.\ndescription: This value should not be blank.",
      "violations": [
        {
          "propertyPath": "name",
          "message": "This value should not be blank."
        },
        {
          "propertyPath": "description",
          "message": "This value should not be blank."
        }
      ]
    }
    """

