@store
Feature: Petstore - Store API Tests
  Como QA quiero verificar que los endpoints de Store funcionen correctamente

  Background:
    * url baseUrl

  @happypath
  Scenario: Crear una orden exitosamente
    Given path '/store/order'
    And request
      """
      {
        "id": 10,
        "petId": 1,
        "quantity": 2,
        "shipDate": "2026-02-23T00:00:00.000+0000",
        "status": "placed",
        "complete": true
      }
      """
    When method post
    Then status 200
    And match response.id == 10
    And match response.petId == 1
    And match response.quantity == 2
    And match response.status == 'placed'
    And match response.complete == true

  @happypath
  Scenario: Obtener una orden por ID exitosamente
    Given path '/store/order'
    And request
      """
      {
        "id": 5,
        "petId": 1,
        "quantity": 1,
        "shipDate": "2026-02-23T00:00:00.000+0000",
        "status": "placed",
        "complete": true
      }
      """
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
    Given path '/store/order'
    And request
      """
      {
        "id": 8,
        "petId": 2,
        "quantity": 1,
        "shipDate": "2026-02-23T00:00:00.000+0000",
        "status": "placed",
        "complete": false
      }
      """
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
    Given path '/store/order'
    And request
      """
      {
        "id": 15,
        "petId": 3,
        "quantity": 5,
        "shipDate": "2026-03-01T00:00:00.000+0000",
        "status": "approved",
        "complete": false
      }
      """
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
