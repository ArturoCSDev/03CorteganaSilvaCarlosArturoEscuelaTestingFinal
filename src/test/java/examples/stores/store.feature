Feature: Petstore - Store API Tests
  Como QA quiero verificar que los endpoints de Store funcionen correctamente

  Background:
    * url baseUrl

  # ============================================
  # POST /store/order - Crear una orden
  # ============================================
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

  # ============================================
  # GET /store/order/{orderId} - Obtener orden por ID
  # ============================================
  Scenario: Obtener una orden por ID exitosamente
    # Primero creamos la orden
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

    # Ahora la consultamos
    Given path '/store/order/5'
    When method get
    Then status 200
    And match response.id == 5
    And match response.petId == 1
    And match response.status == 'placed'

  Scenario: Obtener una orden con ID que no existe
    Given path '/store/order/9999'
    When method get
    Then status 404

  # ============================================
  # DELETE /store/order/{orderId} - Eliminar una orden
  # ============================================
  Scenario: Eliminar una orden exitosamente
    # Primero creamos la orden
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

    # Ahora la eliminamos
    Given path '/store/order/8'
    When method delete
    Then status 200

  # ============================================
  # GET /store/inventory - Obtener inventario
  # ============================================
  Scenario: Obtener el inventario de la tienda
    Given path '/store/inventory'
    When method get
    Then status 200
    And match response != null
