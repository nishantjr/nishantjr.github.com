'use strict'

const Metalsmith = require('metalsmith'),
      markdown   = require('metalsmith-markdownit')

const printFilename =
  (files, metalsmith, done) => {
    for (const file in files)
      console.log(file)
    done()
  }

Metalsmith(__dirname)
  .destination('.build/www')
  .use(markdown())
  .build(function(err) {
    if (err) throw err;
      console.log('Done.');
  })
