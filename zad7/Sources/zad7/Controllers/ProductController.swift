struct ProductController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let products = routes.grouped("products")
        products.get(use: index)
        products.get("create", use: create)
        products.post("create", use: createPost)
        products.get(":id", "edit", use: edit)
        products.post(":id", "edit", use: editPost)
        products.post(":id", "delete", use: delete)
    }

    func index(req: Request) async throws -> View {
        let products = try await Product.query(on: req.db).with(\.$category).all()
        return try await req.view.render("Products/index", ["products": products])
    }

    func create(req: Request) async throws -> View {
        let categories = try await Category.query(on: req.db).all()
        return try await req.view.render("Products/create", ["categories": categories])
    }

    func createPost(req: Request) async throws -> Response {
        let product = try req.content.decode(Product.self)
        try await product.save(on: req.db)

        try await req.redis.set("lastCreatedProduct", to: product.name)

        return req.redirect(to: "/products")
    }

    func edit(req: Request) async throws -> View {
        let product = try await Product.find(req.parameters.get("id"), on: req.db)!
        let categories = try await Category.query(on: req.db).all()
        return try await req.view.render("Products/edit", ["product": product, "categories": categories])
    }

    func editPost(req: Request) async throws -> Response {
        let updated = try req.content.decode(Product.self)
        let product = try await Product.find(req.parameters.get("id"), on: req.db)!
        product.name = updated.name
        product.price = updated.price
        product.$category.id = updated.$category.id
        try await product.save(on: req.db)
        return req.redirect(to: "/products")
    }

    func delete(req: Request) async throws -> Response {
        if let product = try await Product.find(req.parameters.get("id"), on: req.db) {
            try await product.delete(on: req.db)
        }
        return req.redirect(to: "/products")
    }
}
