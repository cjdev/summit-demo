require('isomorphic-fetch');
const express = require('express');

var app = express();

app.use(require('cors')());

app.get('/greeting', (req, res) => {
  res.json({ message: 'Hello, world!' });
});

app.use((err, req, res, next) => {
  if (err.name === 'UnauthorizedError') {
    res.status(401).json({ error: 'unauthorized' });
  } else {
    next(err);
  }
});

app.listen(8080, () => { console.log('listening on port 8080'); });
