'use strict'

const gulp = require('gulp'),
      metalsmith = require('./lib/site'),
      serve = require('metalsmith-serve'),
      watch = require('metalsmith-watch')

function build(metalsmith, cb) {
  metalsmith.build(function(err) {
      if (err) throw err;
      cb();
  })
}

gulp.task('build', (cb) => { build(metalsmith, cb) });
gulp.task('serve', ['build'], (cb) => {
    build(metalsmith.use(serve({ host: '0.0.0.0', port: 8080, verbose: true }))
                    .use(watch({ pattern: '**/*', livereload: true })),
          cb)
})
