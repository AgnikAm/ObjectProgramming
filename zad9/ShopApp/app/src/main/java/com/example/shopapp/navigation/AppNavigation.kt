import androidx.compose.runtime.Composable
import androidx.navigation.compose.*

@Composable
fun AppNavigation() {
    val navController = rememberNavController()
    NavHost(navController, startDestination = "categories") {
        composable("categories") {
            CategoryScreen(navController)
        }
        composable("products/{categoryId}") { backStackEntry ->
            val categoryId = backStackEntry.arguments?.getString("categoryId")?.toIntOrNull()
            categoryId?.let { ProductScreen(navController, it) }
        }
        composable("cart") {
            CartScreen(cart)
        }
    }
}
