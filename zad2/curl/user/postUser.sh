curl -X POST -H "Content-Type: application/json" \
-d '{
  "email": "test@example.com",
  "password": "haslo123",
  "firstName": "Jan",
  "lastName": "Kowalski",
  "roles": ["ROLE_USER"]
}' \
http://localhost:8000/user/new