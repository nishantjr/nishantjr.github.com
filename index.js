'use strict'

const Metalsmith = require('metalsmith')
    , inPlace    = require('metalsmith-in-place')
    , layouts    = require('metalsmith-layouts')
    , linkcheck  = require('metalsmith-linkcheck')
    , markdown   = require('metalsmith-markdownit')
    , permalinks = require('metalsmith-permalinks')

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

const setBlogPostMetadata =
  (files, metalsmith, done) => {
    for (const file in files) {
      const match = file.match(/(\d{4}-\d{2}-\d{2})-(.*)\.html/)
      if (match) {
        const fileData = files[file]
        fileData.date = new Date(match[1])
        fileData.slug = match[2]
        fileData.layout = 'default.html'
        fileData.comments = true
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
  .use(inPlace({
    engine: 'liquid',
    includeDir: 'partials',
    customTags: { height: (meters) => {
      const feet = Math.round(3.281 * meters.trim())
      return ' <span class="altitude">(' + meters + " m / " + feet + " ft)</span> "
    }}
  }))
  .use(markdown({html: true, typographer: true}))
  .use(inPath('blog/', setBlogPostMetadata))
  .use(inPath('blog/', permalinks({
    pattern: 'blog/:date/:slug',
    date: 'YYYY/MM/DD'
  })))
  .use(layouts({
    engine: 'liquid',
    directory: 'templates',
    includeDir: 'partials',
  }))
  .use(linkcheck({
    checkFile: '../.build/links-checked.json',
    failFile: '../.build/links-failed.json',
  }))
  .build(function(err) {
    if (err) throw err;
      console.log('Done.');
  })
