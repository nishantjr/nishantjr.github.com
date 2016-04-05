'use strict'

const Metalsmith = require('metalsmith'),
      markdown   = require('metalsmith-markdownit')

Metalsmith(__dirname)
  .destination('.build/www')
  .use(markdown())
  .build(function(err) {
    if (err) throw err;
      console.log('Done.');
  })
