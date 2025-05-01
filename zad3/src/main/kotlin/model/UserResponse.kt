package model

data class UserResponse(
    val username: String,
    val passwordHash: String
)