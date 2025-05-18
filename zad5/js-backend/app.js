const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');
const sequelize = require('./config/database');
const Product = require('./models/Product');
const Cart = require('./models/Cart');
const Payment = require('./models/Payment');
const routes = require('./routes');

const app = express();

app.use(cors({ origin: 'http://localhost:3000' }));
app.use(bodyParser.json());
app.use('/', routes);

const PORT = 8080;

Cart.belongsToMany(Product, { through: 'CartProducts' });
Product.belongsToMany(Cart, { through: 'CartProducts' });

(async () => {
  try {
    await sequelize.sync({ alter: true });

    app.listen(PORT, () => {
      console.log(`Server running at http://localhost:${PORT}`);
    });
  } catch (err) {
    console.error('Failed to start server:', err);
  }
})();
