package app

import org.springframework.boot.autoconfigure.SpringBootApplication
import org.springframework.boot.runApplication

@SpringBootApplication(scanBasePackages = ["app", "controller", "service", "model"])
open class AuthApplication

fun main(args: Array<String>) {
    runApplication<AuthApplication>(*args)
}