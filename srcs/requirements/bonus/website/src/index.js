const express = require('express')
var serveStatic = require('serve-static')
const port = 3000

var app = express()
app.use(serveStatic('/var/www/resume', { index: ['default.html', 'default.htm', 'index.html'] }))
app.listen(port, '0.0.0.0', () => {
  console.log(`Example app listening on port ${port}`)
})
