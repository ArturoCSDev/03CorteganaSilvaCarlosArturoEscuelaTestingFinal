@store
Feature: Petstore - Store API Tests
  Como QA quiero verificar que los endpoints de Store funcionen correctamente

  Background:
    * url baseUrl

  @happypath
  Scenario: Crear una orden exitosamente
    * def id = 10
    * def petId = 1
    * def quantity = 2
    * def shipDate = '2026-02-23T00:00:00.000+0000'
    * def status = 'placed'
    * def complete = true
    Given path '/store/order'
    And request read('data/order.json')
    When method post
    Then status 200
    And match response.id == 10
    And match response.petId == 1
    And match response.quantity == 2
    And match response.status == 'placed'
    And match response.complete == true

  @happypath
  Scenario: Obtener una orden por ID exitosamente
    * def id = 5
    * def petId = 1
    * def quantity = 1
    * def shipDate = '2026-02-23T00:00:00.000+0000'
    * def status = 'placed'
    * def complete = true
    Given path '/store/order'
    And request read('data/order.json')
    When method post
    Then status 200

    Given path '/store/order/5'
    When method get
    Then status 200
    And match response.id == 5
    And match response.petId == 1
    And match response.status == 'placed'

  @unhappypath
  Scenario: Obtener una orden con ID que no existe
    Given path '/store/order/9999'
    When method get
    Then status 404

  @happypath
  Scenario: Eliminar una orden exitosamente
    * def id = 8
    * def petId = 2
    * def quantity = 1
    * def shipDate = '2026-02-23T00:00:00.000+0000'
    * def status = 'placed'
    * def complete = false
    Given path '/store/order'
    And request read('data/order.json')
    When method post
    Then status 200

    Given path '/store/order/8'
    When method delete
    Then status 200

  @happypath
  Scenario: Obtener el inventario de la tienda
    Given path '/store/inventory'
    When method get
    Then status 200
    And match response != null

  @unhappypath
  Scenario: Eliminar una orden que no existe
    Given path '/store/order/77777'
    When method delete
    Then status 404

  @unhappypath
  Scenario: Obtener una orden con ID invalido
    Given path '/store/order/abc'
    When method get
    Then status 404
    And match response.message == 'java.lang.NumberFormatException: For input string: \"abc\"'

  @happypath
  Scenario: Crear una orden y verificar sus datos con GET
    * def id = 15
    * def petId = 3
    * def quantity = 5
    * def shipDate = '2026-03-01T00:00:00.000+0000'
    * def status = 'approved'
    * def complete = false
    Given path '/store/order'
    And request read('data/order.json')
    When method post
    Then status 200

    Given path '/store/order/15'
    When method get
    Then status 200
    And match response.id == 15
    And match response.petId == 3
    And match response.quantity == 5
    And match response.status == 'approved'
    And match response.complete == false
