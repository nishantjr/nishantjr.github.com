'use strict'

const gulp = require('gulp'),
      connect = require('gulp-connect'),
      metalsmith = require('./lib/site')

gulp.task('build', (cb) => {
    metalsmith.build(function(err) {
      if (err) throw err;
      cb();
  })
});

gulp.task('serve', ['build'], (cb) => {
    connect.server({
        root: metalsmith._destination
    });
    gulp.watch('src/**/*', ['build'])
    gulp.watch('templates/**/*', ['build'])
})

