curl -X POST http://localhost:8000/order/new \
  -H "Content-Type: application/json" \
  -d '{
    "totalPrice": 199.99,
    "customerEmail": "customer@example.com",
    "products": [1, 2],
    "user": 1
  }'