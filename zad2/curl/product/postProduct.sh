curl -X POST -H "Content-Type: application/json" \
-d '{
  "name": "book4",
  "price": 49.99,
  "category": 2
}' \
http://localhost:8000/product/new