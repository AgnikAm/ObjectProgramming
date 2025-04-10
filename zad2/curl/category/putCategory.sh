curl -X PUT http://localhost:8000/category/1/edit \
  -H "Content-Type: application/json" \
  -d '{
    "name": "Updated Category Name"
  }'