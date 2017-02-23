require('isomorphic-fetch');
const express = require('express');

var app = express();

app.use(require('cors')());
app.use(require('express-jwt')({ secret: process.env.JWT_SECRET }))

app.get('/greeting', (req, res) => {
  fetch(`https://members.cj.com/affapi/oauth/user/${req.user.userId}/company`, {
    headers: { Authorization: req.get('Authorization') }
  }).then(res => res.json())
    .then(body => {
      res.json({ message: `Hello, world!`, companies: body });
    });
});

app.use((err, req, res, next) => {
  if (err.name === 'UnauthorizedError') {
    res.status(401).json({ error: 'unauthorized' });
  } else {
    next(err);
  }
});

app.listen(8080, () => { console.log('listening on port 8080'); });
