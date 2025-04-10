curl -X PUT http://localhost:8000/product/1/edit \
  -H "Content-Type: application/json" \
  -d '{
    "name": "Updated book name",
    "price": 99.99,
    "category": 3
  }'