const express = require('express');
const router = express.Router();

const productController = require('../controllers/productController');
const cartController = require('../controllers/cartController');
const paymentController = require('../controllers/paymentController');

router.post('/products', productController.createProduct);
router.get('/products', productController.getAllProducts);
router.get('/products/:id', productController.getProductById);
router.put('/products/:id', productController.updateProduct);
router.delete('/products/:id', productController.deleteProduct);

router.post('/carts', cartController.addToCart);
router.get('/carts', cartController.getAllCarts);
router.get('/carts/:id', cartController.getCart);
router.put('/carts/:id', cartController.updateCart);
router.delete('/carts/:id', cartController.deleteCart);

router.post('/payments', paymentController.createPayment);
router.get('/payments', paymentController.getAllPayments);

module.exports = router;
