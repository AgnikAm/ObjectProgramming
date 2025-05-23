package controller

import service.AuthService
import model.Credentials
import model.Response
import model.UserResponse
import org.springframework.web.bind.annotation.*

@RestController
@RequestMapping("/api")
class AuthController(
    private val authService: AuthService
) {
    @GetMapping("/users")
    fun getUsers(): List<UserResponse> {
        return authService.getAllUsers()
    }

    @PostMapping("/register")
    fun register(@RequestBody credentials: Credentials): Response {
        return try {
            authService.registerUser(credentials.username, credentials.password)
            Response(true, "User registered successfully")
        } catch (e: Exception) {
            Response(false, "Registration failed: ${e.message}")
        }
    }

    @PostMapping("/login")
    fun login(@RequestBody credentials: Credentials): Response {
        val isAuthenticated = authService.authenticate(credentials.username, credentials.password)
        return Response(
            success = isAuthenticated,
            message = if (isAuthenticated) "Login successful" else "Invalid credentials"
        )
    }
}