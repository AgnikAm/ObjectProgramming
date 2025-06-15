import Fluent
import Vapor

func routes(_ app: Application) throws {
    app.get { req async throws in
        try await req.view.render("base", ["title": "Hello Vapor!"])
    }

    app.get("hello") { req async -> String in
        "Hello, world!"
    }

    // Zarejestruj kontroler produktów
    try app.register(collection: ProductController())

    // Jeśli masz inne kontrolery, np. TodoController:
    // try app.register(collection: TodoController())
}
