package service

import org.springframework.stereotype.Service
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder

@Service
class AuthService {
    private val passwordEncoder = BCryptPasswordEncoder()
    private val userDatabase = mutableMapOf<String, String>()

    fun registerUser(username: String, plainPassword: String) {
        userDatabase[username] = passwordEncoder.encode(plainPassword)
    }

    fun authenticate(username: String, plainPassword: String): Boolean {
        val storedHash = userDatabase[username] ?: return false
        return passwordEncoder.matches(plainPassword, storedHash)
    }

    fun getAllUsers(): Map<String, String> {
        return userDatabase.toMap()
    }
}