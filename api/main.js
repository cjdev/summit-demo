require('isomorphic-fetch');
const express = require('express');

var app = express();

app.use(require('cors')());

app.get('/greeting', (req, res) => {
  res.json({ message: 'Hello, world!!!' });
});

app.listen(8080, () => { console.log('listening on port 8080'); });
