import Vapor
import Fluent

struct ProductController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let products = routes.grouped("products")
        products.get(use: index)
        products.get("create", use: create)
        products.post("create", use: store)
        products.get(":id", use: show)
        products.get(":id", "edit", use: edit)
        products.post(":id", "edit", use: update)
        products.post(":id", "delete", use: delete)
    }

    func index(req: Request) async throws -> View {
    let products = try await Product.query(on: req.db).all()

    // Uproszczenie danych do typów zgodnych z Leaf (Leaf nie potrafi używać Swiftowych obiektów)
    let productDicts = products.map { product in
        [
            "id": product.id?.uuidString ?? "",
            "name": product.name,
            "price": String(format: "%.2f", product.price)
        ]
    }

        return try await req.view.render("productsIndex", ["products": productDicts])
    }


    func create(req: Request) async throws -> View {
        return try await req.view.render("productsCreate")
    }

    func store(req: Request) async throws -> Response {
        let input: ProductInput = try req.content.decode(ProductInput.self)
        let product: Product = Product(name: input.name, price: input.price)
        try await product.save(on: req.db)
        return req.redirect(to: "/products")
    }

    func show(req: Request) async throws -> View {
        guard let product: Product = try await Product.find(req.parameters.get("id"), on: req.db) else {
            throw Abort(.notFound)
        }
        return try await req.view.render("Products/show", ["product": product])
    }

    func edit(req: Request) async throws -> View {
        guard let product: Product = try await Product.find(req.parameters.get("id"), on: req.db) else {
            throw Abort(.notFound)
        }
        return try await req.view.render("Products/edit", ["product": product])
    }

    func update(req: Request) async throws -> Response {
        let input: ProductInput = try req.content.decode(ProductInput.self)
        guard let product: Product = try await Product.find(req.parameters.get("id"), on: req.db) else {
            throw Abort(.notFound)
        }
        product.name = input.name
        product.price = input.price
        try await product.save(on: req.db)
        return req.redirect(to: "/products")
    }

    func delete(req: Request) async throws -> Response {
        guard let product: Product = try await Product.find(req.parameters.get("id"), on: req.db) else {
            throw Abort(.notFound)
        }
        try await product.delete(on: req.db)
        return req.redirect(to: "/products")
    }
}

struct ProductInput: Content {
    let name: String
    let price: Double
}
