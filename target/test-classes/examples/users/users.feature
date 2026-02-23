Feature: Petstore - User API Tests
  Como QA quiero verificar que los endpoints de User funcionen correctamente

  Background:
    * url baseUrl

  # ============================================
  # POST /user - Crear un usuario
  # ============================================
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

  # ============================================
  # POST /user/createWithList - Crear usuarios con lista
  # ============================================
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

  # ============================================
  # GET /user/{username} - Obtener usuario por username
  # ============================================
  Scenario: Obtener un usuario por username
    # Primero creamos el usuario
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

    # Ahora lo consultamos
    Given path '/user/testuser_get'
    When method get
    Then status 200
    And match response.username == 'testuser_get'
    And match response.firstName == 'Test'
    And match response.lastName == 'User'
    And match response.email == 'testget@test.com'

  Scenario: Obtener un usuario que no existe
    Given path '/user/usuario_inexistente_xyz'
    When method get
    Then status 404

  # ============================================
  # PUT /user/{username} - Actualizar usuario
  # ============================================
  Scenario: Actualizar un usuario exitosamente
    # Primero creamos el usuario
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

    # Ahora lo actualizamos
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

    # Verificamos que se actualizó
    Given path '/user/testuser_update'
    When method get
    Then status 200
    And match response.firstName == 'Despues'
    And match response.lastName == 'Actualizado'
    And match response.email == 'despues@test.com'

  # ============================================
  # DELETE /user/{username} - Eliminar usuario
  # ============================================
  Scenario: Eliminar un usuario exitosamente
    # Primero creamos el usuario
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

    # Ahora lo eliminamos
    Given path '/user/testuser_delete'
    When method delete
    Then status 200

  # ============================================
  # GET /user/login - Login de usuario
  # ============================================
  Scenario: Login de usuario exitoso
    # Primero creamos el usuario
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

    # Ahora hacemos login
    Given path '/user/login'
    And param username = 'loginuser'
    And param password = 'loginpass'
    When method get
    Then status 200
    And match response.message contains 'logged in user session'

  # ============================================
  # GET /user/logout - Logout de usuario
  # ============================================
  Scenario: Logout de usuario exitoso
    Given path '/user/logout'
    When method get
    Then status 200
