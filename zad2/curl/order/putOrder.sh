curl -X PUT http://localhost:8000/order/1/edit \
  -H "Content-Type: application/json" \
  -d '{
    "totalPrice": 249.99,
    "customerEmail": "updated@example.com",
    "products": [1, 3],
    "user": 2
  }'