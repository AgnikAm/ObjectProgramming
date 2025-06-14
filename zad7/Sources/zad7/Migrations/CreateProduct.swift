struct CreateProduct: Migration {
    func prepare(on db: Database) -> EventLoopFuture<Void> {
        db.schema("products")
            .id()
            .field("name", .string, .required)
            .field("price", .double, .required)
            .field("category_id", .uuid, .required, .references("categories", "id"))
            .create()
    }

    func revert(on db: Database) -> EventLoopFuture<Void> {
        db.schema("products").delete()
    }
}
