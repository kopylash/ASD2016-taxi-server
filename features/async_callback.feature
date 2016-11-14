Feature: Taxi booking system
  As a customer
  So that I can get a taxi ride
  I want to send my coordinates and booking request

  @javascript
  Scenario: Asynchronous callback
    Given I am in the booking page
    When I provide my coordinates
    And I submit this information
    Then I should be notified that my information is being processed
    And I should eventually receive an asynchronous message with my address