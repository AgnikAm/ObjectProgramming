package com.example.shopapp.models

data class Product(
    val id: Int,
    val categoryId: Int,
    val name: String,
    val price: Double
)