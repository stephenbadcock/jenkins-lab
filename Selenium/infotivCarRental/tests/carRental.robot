*** Settings ***
Documentation    Tests for Infotiv's car rental site: https://rental4.infotiv.net/
Resource    ../resources/carRentalResources.robot
Suite Setup    Setup test environment
Test Setup    Initialize Test
Test Teardown    Cancel all bookings
Suite Teardown    Close test environment

*** Test Cases ***
Scenario: User books a car
    Given User is on date selection page
    When User logs in with valid credentials    ${valid_user_email}    ${valid_user_password}    ${user_first_name}
    And User selects rental period    ${days_until_pickup}    ${days_until_return}
    And User selects car    ${license_number}
    And User submits credit card info    ${card_number}    ${card_holder}    ${card_expire_month}    ${card_expire_year}    ${card_cvc}
    Then A confirmation of the booking is shown    ${car_model}    ${pickup_date}

Scenario: User tries to log in with invalid credentials
    Given User is on date selection page
    When User tries to log in with invalid credentials    ${invalid_user_email}    ${invalid_user_password}
    Then An error message appears to the left of the buttons

Scenario: User tries to book car without being logged in
    Given User is on date selection page
    When User selects rental period    ${days_until_pickup}    ${days_until_return}
    And User selects car    ${license_number2}
    Then An error message appears on the page

Scenario: User books a car and then cancels booking
    Given User is on date selection page
    When User logs in with valid credentials    ${valid_user_email}    ${valid_user_password}    ${user_first_name}
    And User selects rental period    ${days_until_pickup}    ${days_until_return}
    And User selects car    ${license_number2}
    And User submits credit card info    ${card_number}    ${card_holder}    ${card_expire_month}    ${card_expire_year}    ${card_cvc}
    And User cancels booking on 'My page'    ${license_number2}
    Then A confirmation of the cancellation is shown    ${license_number2}