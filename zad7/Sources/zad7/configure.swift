import Fluent
import FluentPostgresDriver
import Leaf
import Redis
import Vapor

public func configure(_ app: Application) throws {
    // Baza danych
    app.databases.use(.postgres(
        hostname: "localhost",
        username: "kklima",
        password: "",
        database: "antywzorce"
    ), as: .psql)

    // Leaf jako silnik szablonów
    app.views.use(.leaf)

    // Redis
    app.redis.configuration = try RedisConfiguration(hostname: "localhost")

    // Migracje (dodamy później)
    app.migrations.add(CreateProduct())

    try routes(app)
}
