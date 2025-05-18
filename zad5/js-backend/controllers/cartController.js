const Cart = require('../models/Cart');
const Product = require('../models/Product');

exports.addToCart = async (req, res) => {
  const cart = req.body;

  if (!cart.products || !Array.isArray(cart.products)) {
    return res.status(400).json({ error: 'Invalid cart format' });
  }

  const productIds = cart.products.map(p => p.id);

  try {
    const products = await Product.findAll({ where: { id: productIds } });
    
    const newCart = await Cart.create();
    await newCart.setProducts(products);
    const cartWithProducts = await Cart.findByPk(newCart.id, { include: Product });

    res.status(201).json(cartWithProducts);
  } catch (err) {
    res.status(500).json({ error: 'Could not create cart' });
  }
};

exports.getCart = async (req, res) => {
  try {
    const cart = await Cart.findByPk(req.params.id, { include: Product });
    if (!cart) return res.status(404).json({ error: 'Cart not found' });
    res.json(cart);
  } catch (err) {
    res.status(500).json({ error: 'Error retrieving cart' });
  }
};

exports.getAllCarts = async (req, res) => {
  try {
    const carts = await Cart.findAll({ include: Product });
    res.json(carts);
  } catch (err) {
    res.status(500).json({ error: 'Error retrieving carts' });
  }
};

exports.updateCart = async (req, res) => {
  try {
    const { products } = req.body;
    const productIds = products.map(p => p.id);

    const cart = await Cart.findByPk(req.params.id);
    if (!cart) return res.status(404).json({ error: 'Cart not found' });

    const foundProducts = await Product.findAll({ where: { id: productIds } });
    await cart.setProducts(foundProducts);

    const updatedCart = await Cart.findByPk(req.params.id, { include: Product });
    res.json(updatedCart);
  } catch (err) {
    res.status(500).json({ error: 'Failed to update cart' });
  }
};

exports.deleteCart = async (req, res) => {
  try {
    const cart = await Cart.findByPk(req.params.id);
    if (!cart) return res.status(404).json({ error: 'Cart not found' });

    await cart.setProducts([]);
    await cart.destroy();
    res.sendStatus(204);
  } catch (err) {
    res.status(500).json({ error: 'Failed to delete cart' });
  }
};
