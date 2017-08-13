Archer Task Logger API - The API for the app "Archer Task Logger"
==========================

**Archer Task Logger** it will be a web application to log your work, allowing you to have a list of the tasks/tickets you worked in a day.

***Note: This is a little project which is in progress***

##### Personal Goal
My main goal for me in making this project is to use it later to log the tickets my team and I are working. Then weekly or monthly we would be able to make a report and send it to our customers.

##### Why do not use an existing app?
We want an app which fit our need in a simple way. 🤓

## Entities used in the API
* **Customer** The client who owns the project you're working on.
* **Projects** The projects of a customer.
* **Teams** A group of users who belong to a Customer and work for his projects.
* **Users** Each member of a team who has one or more projects to work.


## Specifications
This API uses the framework **[API Platform](https://api-platform.com/)** by Kévin Dunglas. It is based on [Symfony](symfony.com) and its main features are:
* Linked data as data representation format by [JSON-ld](https://json-ld.org/).
* CORS headers.
* Behavior-Driven Development by the framework [Behat](http://behat.org/en/latest/).
* Hypermedia-driven Web API by [Hydra](http://www.hydra-cg.com/)
* Object Relational Doctrine (ORM) by [doctrine](http://www.doctrine-project.org/)


## Install
First of all, make sure you have Docker on your computer. Then, you can proceed with the following steps:
1. Download the project files.
```bash
$ git clone git@github.com:darieldejesus/archer-task-logger-api.git archer-api
$ cd archer-api/
```
2. Run Docker-Compose in order to start the project containers. It will download the required containers.
```bash
$ docker-compose up -d
```
3. Generate the database and tables.
```bash
$ docker-compose exec web bin/console doctrine:schema:create
```
4. At this step, the environment is already working. Just need to go to `http://localhost/app_dev.php` to see the development environment.
 
## Tests
In order to confirm all endpoints are working as expected, you can run behat which will execute the BDD tests. You can see the files [here](https://github.com/darieldejesus/archer-task-logger-api/tree/master/features).
1. Clean the `test` environment.
```bash
$ docker-compose exec web bin/console cache:clear --env=test
```
2. Run the tests.
```bash
$ docker-compose run --rm web vendor/bin/behat
```
It will execute the tests using Cucumber language ([Gherkin](https://github.com/cucumber/cucumber/wiki/Gherkin)).


## API Endpoints
This is an example of the endpoins for the User entity. Other entities like Customers, Projects and Tasks follow the same pattern.

| URL | Method | Action |
|---|---|---|
|/users|**GET**|Retrieve all users|
|/users|**POST**|Create a new user|
|/users/{id}|**GET**|Get a user|
|/users/{id}|**PUT**|Update a user|

#### GET /users
Retrieve all users

Response body:
```json
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
```

### POST /users
Create a new user.

Request body:
```json
{
  "name": "Juan Perez",
  "email": "jperez@example.com",
  "status": 1,
  "team": "/teams/1",
  "projects": [
    "/projects/1"
  ]
}
```
Response body:
```json
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
```

### GET /users/{id}
Retrieve an existing user.

Response body:
```json
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
```

### PUT /users/{id}
Update an existing user.

Request body:
```json
{
  "status": "0"
}
```
Response body:
```json
{
  "@context": "/contexts/User",
  "@id": "/users/1",
  "@type": "User",
  "id": 1,
  "name": "Juan Perez",
  "email": "jperez@example.com",
  "status": 0,
  "team": "/teams/1",
  "projects": [
    "/projects/1"
  ]
}
```

### Credits
Created by [Dariel de Jesus](http://www.darieldejesus.com).