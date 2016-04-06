'use strict'

const Metalsmith = require('metalsmith'),
      linkcheck  = require('metalsmith-linkcheck'),
      markdown   = require('metalsmith-markdownit'),
      permalinks = require('metalsmith-permalinks')

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

const extractDateSlugFromFilename =
  (files, metalsmith, done) => {
    for (const file in files) {
      const match = file.match(/(\d{4}-\d{2}-\d{2})-(.*)\.html/)
      if (match) {
        files[file].date = new Date(match[1])
        files[file].slug = match[2]
      }
      else console.warn(file + " doesn't include date or slug.")
    }
    done()
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
  .use(inPath('blog/', extractDateSlugFromFilename))
  .use(inPath('blog/', permalinks({
    pattern: 'blog/:date/:slug',
    date: 'YYYY/MM/DD'
  })))
  .use(linkcheck({
    checkFile: '../.build/links-checked.json',
    failFile: '../.build/links-failed.json',
  }))
  .build(function(err) {
    if (err) throw err;
      console.log('Done.');
  })
