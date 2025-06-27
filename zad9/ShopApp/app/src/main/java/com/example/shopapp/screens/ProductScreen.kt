import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.material.Button
import androidx.compose.material.Card
import androidx.compose.material.MaterialTheme
import androidx.compose.material.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.mutableStateListOf
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp
import androidx.navigation.NavHostController
import com.example.shopapp.models.Product
import com.example.shopapp.repository.Repository

var cart = mutableStateListOf<Product>()

@Composable
fun ProductScreen(navController: NavHostController, categoryId: Int) {
    val products = Repository.products.filter { it.categoryId == categoryId }

    Column(modifier = Modifier
        .fillMaxSize()
        .padding(16.dp)) {

        Row(
            modifier = Modifier
                .fillMaxWidth()
                .padding(bottom = 16.dp),
            horizontalArrangement = Arrangement.SpaceBetween
        ) {
            Text("Produkty", style = MaterialTheme.typography.h4)
            Button(onClick = { navController.navigate("cart") }) {
                Text("Koszyk (${cart.size})")
            }
        }

        LazyColumn(verticalArrangement = Arrangement.spacedBy(8.dp)) {
            items(products) { product ->
                Card(
                    elevation = 4.dp,
                    modifier = Modifier.fillMaxWidth()
                ) {
                    Row(
                        modifier = Modifier
                            .padding(16.dp)
                            .fillMaxWidth(),
                        horizontalArrangement = Arrangement.SpaceBetween
                    ) {
                        Column {
                            Text(product.name, style = MaterialTheme.typography.h6)
                            Text("${product.price} zł", style = MaterialTheme.typography.body2)
                        }
                        Button(onClick = { cart.add(product) }) {
                            Text("Dodaj")
                        }
                    }
                }
            }
        }
    }
}

