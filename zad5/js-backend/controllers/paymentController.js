const Payment = require('../models/Payment');
const Cart = require('../models/Cart');
const Product = require('../models/Product');

exports.createPayment = async (req, res) => {
  try {
    const { cartId, cardNumber } = req.body;

    const cart = await Cart.findByPk(cartId, { include: Product });
    if (!cart) return res.status(404).json({ error: 'Cart not found' });

    const amount = cart.Products.reduce((sum, p) => sum + p.price, 0);
    const payment = await Payment.create({ cartId, cardNumber, amount });

    res.status(201).json(payment);
  } catch (err) {
    res.status(500).json({ error: 'Failed to process payment' });
  }
};

exports.getAllPayments = async (req, res) => {
  try {
    const payments = await Payment.findAll();
    res.json(payments);
  } catch (err) {
    res.status(500).json({ error: 'Failed to fetch payments' });
  }
};
