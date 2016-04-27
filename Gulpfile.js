'use strict'

const gulp = require('gulp')
const metalsmith = require('./lib/site')

gulp.task('build', (cb) => {
    metalsmith.build(function(err) {
      if (err) throw err;
      cb();
  })
});
