curl -X PUT -H "Content-Type: application/json" \
-d '{
  "firstName": "NewName",
  "lastName": "NewSurname"
}' \
http://localhost:8000/user/1/edit