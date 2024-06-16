Feature: Get an article & do the assertions 

  Background: Define URL
    Given url apiURL

  @smoke
  Scenario: 001 - Get an article
    Given path 'tags'
    When method Get
    Then status 200
    And match response.tags contains ['est', 'enim']
    And match response.tags !contains 'car'
    And match response.tags contains any ['est', 'enim']
    And match response.tags == "#array"
    And match each response.tags == "#string"

  Scenario: 002- GET an article with Params - https://api.realworld.io/api/articles?limit=10&offset=0
    * def timeValidator = read('classpath:helpers/timeValidator.js')

    Given url 'https://api.realworld.io/api/'
    Given path 'articles'
    Given params { limit: 10, offset:0}
    When method Get
    Then status 200
    And match response.articles == '#[10]'
    # And match response.articlesCount == 349
    # And match response == {"articles" : "#array", "articlesCount": 261}
    And match response.articles[0].createdAt contains '2024'
    And match response.articles[*].favoritesCount contains 1
    
    # .. to get the sub level in JSON object
    And match response..bio contains null
    And match each response..following == '#boolean'
    
    # schema validation
    And match each response.articles == 
    """
      {
            "slug": "#string",
            "title": "#string",
            "description": "#string",
            "body": "#string",
            "tagList": "#array",
            "createdAt": "#? timeValidator(_)",
            "updatedAt": "#? timeValidator(_)",
            "favorited": "#boolean",
            "favoritesCount": "#number",
            "author": {
                "username": "#string",
                "bio": "##string",
                "image": "#string",
                "following": "#boolean"
            }
        }
    """

  Scenario: 003 - Like the article if the favoritesCount = 0
    Given params { limit: 10, offset:0}
    Given path 'articles'
    When method Get
    Then status 200
    * def favoritesCount = response.articles[0].favoritesCount 
    * def article = response.articles[0]

    # * if (favoritesCount == 0) karate.call('classpath:helpers/AddLikes.feature', article)
    * def result = favoritesCount == 0 ? karate.call('classpath:helpers/AddLikes.feature', article).likesCount : favoritesCount
    
    Given params { limit: 10, offset:0}
    Given path 'articles'
    When method Get
    Then status 200

  Scenario: 004 - Retry call
    * configure retry = {count: 10, interval : 5000}

    Given params { limit: 10, offset:0}
    Given path 'articles'
    And retry until response.articles[0].favoritesCount == 1
    When method Get
    Then status 200