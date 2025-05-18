const { DataTypes } = require('sequelize');
const sequelize = require('../config/database');
const Product = require('./Product');

const Cart = sequelize.define('Cart', {});

Cart.belongsToMany(Product, { through: 'cart_products' });
Product.belongsToMany(Cart, { through: 'cart_products' });

module.exports = Cart;
