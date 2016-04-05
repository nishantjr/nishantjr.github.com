'use strict'

const Metalsmith = require('metalsmith')

Metalsmith(__dirname)
  .destination('.build/www')
  .build(function(err) {
    if (err) throw err;
      console.log('Done.');
  })
