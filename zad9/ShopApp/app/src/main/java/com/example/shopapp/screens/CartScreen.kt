import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.material.*
import androidx.compose.runtime.*
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp
import com.example.shopapp.models.Product

@Composable
fun CartScreen(cart: MutableList<Product>) {
    var name by remember { mutableStateOf("") }
    var surname by remember { mutableStateOf("") }
    var cardNumber by remember { mutableStateOf("") }

    Column(modifier = Modifier.padding(16.dp)) {
        Text("Twój koszyk", style = MaterialTheme.typography.h5)

        if (cart.isEmpty()) {
            Text("Koszyk jest pusty.", modifier = Modifier.padding(top = 16.dp))
        } else {
            LazyColumn(modifier = Modifier.weight(1f)) {
                items(cart) { product ->
                    Row(
                        modifier = Modifier
                            .fillMaxWidth()
                            .padding(vertical = 8.dp),
                        horizontalArrangement = Arrangement.SpaceBetween
                    ) {
                        Column {
                            Text("${product.name}")
                            Text("${product.price} zł")
                        }
                        Button(onClick = { cart.remove(product) }) {
                            Text("Usuń")
                        }
                    }
                }
            }

            val total = cart.sumOf { it.price }
            Text(
                "Suma: %.2f zł".format(total),
                style = MaterialTheme.typography.h6,
                modifier = Modifier.padding(top = 16.dp)
            )

            Spacer(modifier = Modifier.height(16.dp))

            OutlinedTextField(
                value = name,
                onValueChange = { name = it },
                label = { Text("Imię") },
                modifier = Modifier.fillMaxWidth()
            )
            OutlinedTextField(
                value = surname,
                onValueChange = { surname = it },
                label = { Text("Nazwisko") },
                modifier = Modifier.fillMaxWidth()
            )
            OutlinedTextField(
                value = cardNumber,
                onValueChange = { cardNumber = it },
                label = { Text("Numer karty") },
                modifier = Modifier.fillMaxWidth()
            )

            Spacer(modifier = Modifier.height(16.dp))

            Button(
                onClick = {
                    if (name.isNotBlank() && surname.isNotBlank() && cardNumber.length == 12) {
                        cart.clear()
                    }
                },
                modifier = Modifier.fillMaxWidth()
            ) {
                Text("Zapłać")
            }
        }
    }
}
