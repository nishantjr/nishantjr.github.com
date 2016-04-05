'use strict'

const Metalsmith = require('metalsmith'),
      markdown   = require('metalsmith-markdownit')

const inPath = (path, plugin) =>
  (files, metalsmith, done) => {
    const filteredFiles = {}
    for (const file in files)
      if (file.startsWith(path)) {
        filteredFiles[file] = files[file]
        delete files[file]
      }

    const next = () => { Object.assign(files, filteredFiles); done() }
    plugin(filteredFiles, metalsmith, next)
  }

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
