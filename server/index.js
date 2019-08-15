require('dotenv').config({ path: 'variables.env' });

const express = require('express');
const bodyParser = require('body-parser');
const uuidv4 = require('uuid/v4');
const PushNotifications = require('@pusher/push-notifications-server');

let beamsClient = new PushNotifications({
  instanceId: process.env.INSTANCE_ID,
  secretKey: process.env.SECRET_KEY,
});

const app = express();

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

const users = [];

app.post('/login', (req, res) => {
  const username = req.body.username;

  if (username === undefined || username.length == 0) {
    res.status(400).send({
      status: false,
      message: 'Please provide your username',
    });
    return;
  }

  let user = users.find(u => u.name.trim() === username.trim());

  if (user === undefined) {
    user = {
      id: uuidv4(),
      name: username,
    };

    users.push(user);
  }

  res.status(200);
  res.send({
    status: true,
    message: 'You have been successfully authenticated',
    token: beamsClient.generateToken(user.id),
    user_id: user.id,
  });
});

app.set('port', process.env.PORT || 5200);
const server = app.listen(app.get('port'), () => {
  console.log(`Express running on port ${server.address().port}`);
});
