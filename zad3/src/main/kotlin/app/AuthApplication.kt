package app

import org.springframework.boot.autoconfigure.SpringBootApplication
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.boot.runApplication
import service.AuthService

@SpringBootApplication(scanBasePackages = ["app", "controller", "service", "model"])
open class AuthApplication {

    companion object {
        @Autowired
        lateinit var authService: AuthService
    }
}

fun main(args: Array<String>) {
    runApplication<AuthApplication>(*args)
}