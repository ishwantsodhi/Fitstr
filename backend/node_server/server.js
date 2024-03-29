var restify = require('restify');
var builder = require('botbuilder');
var server = restify.createServer();
var dialog = new builder.LuisDialog('https://api.projectoxford.ai/luis/...');

server.get('/api', function(req, res, next) {
  res.send('hello Rick, I finally work!');
  next();
});
var helloBot = new builder.BotConnectorBot();
helloBot.add('/', new builder.CommandDialog()
    .matches('^set name', builder.DialogAction.beginDialog('/profile'))
    .matches('^quit', builder.DialogAction.endDialog())
    .onDefault([
        function (session, args, next) {
            if (!session.userData.name) {
                session.beginDialog('/profile');
            } else {
                next();
            }
        },
        function (session, results) {
            session.send('Hello %s!', session.userData.name);
        }
    ]));
helloBot.add('/profile',  [
    function (session) {
        if (session.userData.name) {
            builder.Prompts.text(session, 'What would you like to change it to?');
        } else {
            builder.Prompts.text(session, 'Hi! What is your name?');
        }
    },
    function (session, results) {
        session.userData.name = results.response;
        session.endDialog();
    }
]);

server.use(helloBot.verifyBotFramework({ appId: 'Fitme', appSecret: '11c501f74f1a4fdcaad84e1218478ca9' }));
server.get('/', function respond(req, res, next) {
  res.send('hello Rick, I finally work!');
  next();
});
server.post('/api/messages', helloBot.listen());

server.listen(3978, function () {
    console.log('%s listening to %s', server.name, server.url); 
});