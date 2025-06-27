package com.example.shopapp.repository

import com.example.shopapp.models.Category
import com.example.shopapp.models.Product

object Repository {
    val categories = listOf(
        Category(1, "Elektronika"),
        Category(2, "Książki"),
        Category(3, "Ubrania"),
        Category(4, "Dom i ogród"),
        Category(5, "Sport i rekreacja")
    )

    val products = listOf(

        Product(1, 1, "Smartfon", 1200.0),
        Product(2, 1, "Laptop", 3500.0),
        Product(3, 1, "Tablet", 999.0),
        Product(4, 1, "Słuchawki bezprzewodowe", 399.0),
        Product(5, 1, "Smartwatch", 699.0),

        Product(6, 2, "Książka o Kotlinie", 59.99),
        Product(7, 2, "Android w praktyce", 79.99),
        Product(8, 2, "Wzorce projektowe", 89.90),
        Product(9, 2, "Clean Code", 99.99),

        Product(10, 3, "T-shirt", 39.99),
        Product(11, 3, "Bluza z kapturem", 89.99),
        Product(12, 3, "Jeansy", 129.99),
        Product(13, 3, "Kurtka zimowa", 249.99),

        Product(14, 4, "Zestaw noży kuchennych", 199.99),
        Product(15, 4, "Poduszka dekoracyjna", 29.99),
        Product(16, 4, "Lampka nocna", 59.99),
        Product(17, 4, "Zestaw doniczek", 49.99),

        Product(18, 5, "Piłka nożna", 69.99),
        Product(19, 5, "Rower górski", 1299.0),
        Product(20, 5, "Hantle (2x5kg)", 119.99),
        Product(21, 5, "Torba sportowa", 89.99)
    )
}

