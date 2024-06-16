Feature: Sign up a new user

Background: Preconditions
    * def dataGenerator = Java.type('helpers.DataGenerator')
    * def randomEmail = dataGenerator.getRandomEmail()
    * def randomUsername = dataGenerator.getRandomUsername()
    * url apiURL
  
Scenario: Sign up a new user    
    Given path 'users'
    And request 
    """
    {
        "user": {
            "email": #(randomEmail),
            "password": "karate123",
            "username": #(randomUsername)
        }
    }
    """
    When method Post
    Then status 201

Scenario Outline: Validate sign up error messages  
    Given path 'users'
    And request 
    """
    {
        "user": {
            "email": "#<email>",
            "password": "#<password>",
            "username": "#<username>"
        }
    }
    """
    When method Post
    Then status 422
    And match response == <errorResponse>

    Examples:
    | email             | password  | username            | errorResponse                                           |
    | #(randomEmail)    | karate123 | karateUser123       | {"errors": {"username": ["has already been taken"]}}    |
    | karate@test.com   | karate123 | #(randomUsername)   | {"errors": {"email": ["has already been taken"]}}       |