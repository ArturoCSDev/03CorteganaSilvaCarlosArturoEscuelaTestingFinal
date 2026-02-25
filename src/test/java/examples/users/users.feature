@users
Feature: Petstore - User API Tests
  Como QA quiero verificar que los endpoints de User funcionen correctamente

  Background:
    * url baseUrl

  @happypath
  Scenario: Crear un usuario exitosamente
    Given path '/user'
    And request
      """
      {
        "id": 100,
        "username": "arturodev",
        "firstName": "Arturo",
        "lastName": "Dev",
        "email": "arturo@testing.com",
        "password": "password123",
        "phone": "123456789",
        "userStatus": 1
      }
      """
    When method post
    Then status 200
    And match response.message != null

  @happypath
  Scenario: Crear multiples usuarios con una lista
    Given path '/user/createWithList'
    And request
      """
      [
        {
          "id": 101,
          "username": "usuario1",
          "firstName": "Juan",
          "lastName": "Perez",
          "email": "juan@test.com",
          "password": "pass123",
          "phone": "111111111",
          "userStatus": 1
        },
        {
          "id": 102,
          "username": "usuario2",
          "firstName": "Maria",
          "lastName": "Lopez",
          "email": "maria@test.com",
          "password": "pass456",
          "phone": "222222222",
          "userStatus": 1
        }
      ]
      """
    When method post
    Then status 200

  @happypath
  Scenario: Crear multiples usuarios con un array
    Given path '/user/createWithArray'
    And request
      """
      [
        {
          "id": 110,
          "username": "arrayuser1",
          "firstName": "Carlos",
          "lastName": "Gomez",
          "email": "carlos@test.com",
          "password": "pass789",
          "phone": "888888888",
          "userStatus": 1
        },
        {
          "id": 111,
          "username": "arrayuser2",
          "firstName": "Ana",
          "lastName": "Torres",
          "email": "ana@test.com",
          "password": "pass321",
          "phone": "999999999",
          "userStatus": 1
        }
      ]
      """
    When method post
    Then status 200

  @happypath
  Scenario: Obtener un usuario por username
    Given path '/user'
    And request
      """
      {
        "id": 103,
        "username": "testuser_get",
        "firstName": "Test",
        "lastName": "User",
        "email": "testget@test.com",
        "password": "pass789",
        "phone": "333333333",
        "userStatus": 1
      }
      """
    When method post
    Then status 200

    Given path '/user/testuser_get'
    When method get
    Then status 200
    And match response.username == 'testuser_get'
    And match response.firstName == 'Test'
    And match response.lastName == 'User'
    And match response.email == 'testget@test.com'

  @unhappypath
  Scenario: Obtener un usuario que no existe
    Given path '/user/usuario_inexistente_xyz'
    When method get
    Then status 404

  @happypath
  Scenario: Actualizar un usuario exitosamente
    Given path '/user'
    And request
      """
      {
        "id": 104,
        "username": "testuser_update",
        "firstName": "Antes",
        "lastName": "Update",
        "email": "antes@test.com",
        "password": "pass000",
        "phone": "444444444",
        "userStatus": 1
      }
      """
    When method post
    Then status 200

    Given path '/user/testuser_update'
    And request
      """
      {
        "id": 104,
        "username": "testuser_update",
        "firstName": "Despues",
        "lastName": "Actualizado",
        "email": "despues@test.com",
        "password": "newpass123",
        "phone": "555555555",
        "userStatus": 1
      }
      """
    When method put
    Then status 200

    Given path '/user/testuser_update'
    When method get
    Then status 200
    And match response.firstName == 'Despues'
    And match response.lastName == 'Actualizado'
    And match response.email == 'despues@test.com'

  @happypath
  Scenario: Eliminar un usuario exitosamente
    Given path '/user'
    And request
      """
      {
        "id": 105,
        "username": "testuser_delete",
        "firstName": "Delete",
        "lastName": "Me",
        "email": "delete@test.com",
        "password": "pass111",
        "phone": "666666666",
        "userStatus": 1
      }
      """
    When method post
    Then status 200

    Given path '/user/testuser_delete'
    When method delete
    Then status 200

  @unhappypath
  Scenario: Eliminar un usuario que no existe
    Given path '/user/usuario_fantasma_999'
    When method delete
    Then status 404

  @happypath
  Scenario: Login de usuario exitoso
    Given path '/user'
    And request
      """
      {
        "id": 106,
        "username": "loginuser",
        "firstName": "Login",
        "lastName": "Test",
        "email": "login@test.com",
        "password": "loginpass",
        "phone": "777777777",
        "userStatus": 1
      }
      """
    When method post
    Then status 200

    Given path '/user/login'
    And param username = 'loginuser'
    And param password = 'loginpass'
    When method get
    Then status 200
    And match response.message contains 'logged in user session'

  @unhappypath
  Scenario: Login sin enviar credenciales
    Given path '/user/login'
    When method get
    Then status 200
    And match response.message contains 'logged in user session'

  @happypath
  Scenario: Logout de usuario exitoso
    Given path '/user/logout'
    When method get
    Then status 200

  @happypath
  Scenario: Verificar que un usuario eliminado ya no existe
    Given path '/user'
    And request
      """
      {
        "id": 120,
        "username": "user_eliminar_verificar",
        "firstName": "Temporal",
        "lastName": "User",
        "email": "temporal@test.com",
        "password": "temppass",
        "phone": "101010101",
        "userStatus": 1
      }
      """
    When method post
    Then status 200

    Given path '/user/user_eliminar_verificar'
    When method delete
    Then status 200

    Given path '/user/user_eliminar_verificar'
    When method get
    Then status 404
