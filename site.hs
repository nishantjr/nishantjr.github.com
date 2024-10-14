--------------------------------------------------------------------------------
{-# LANGUAGE OverloadedStrings #-}
import          Data.Monoid (mappend)
import          System.FilePath
import          Text.Pandoc.Options
import          Text.Pandoc.Extensions
import          Hakyll
import          Hakyll.Images   (loadImage, ensureFitCompiler)

--------------------------------------------------------------------------------
main :: IO ()
main = hakyll $ do
    version "redirects" $ createRedirects redirects

    match ("src/images/**.jpg" .||. "src/images/**.png") $ do
        route   removeInitialComponent
        compile $ loadImage >>= ensureFitCompiler 10000 480

    match "src/css/*" $ do
        route   $ removeInitialComponent
        compile compressCssCompiler

    match "src/index.md" $ do
        route   $ composeRoutes removeInitialComponent $
                                setExtension "html"
        compile $ do
            id <- getUnderlying
            pandocCompiler
                >>= loadAndApplyTemplate "templates/default.html" ((navCtx id) <> defaultContext)

    match "src/blog/*.markdown" $ do
        route   $ composeRoutes removeInitialComponent $
                  composeRoutes dateTitleRoute
                                (setExtension "html")
        compile $ do
            id <- getUnderlying
            pandocCompiler
                >>= saveSnapshot "content"
                >>= loadAndApplyTemplate "templates/comments.html" postContext
                >>= loadAndApplyTemplate "templates/default.html"  ((navCtx id) <> postContext)

    match "templates/*" $ compile templateBodyCompiler

redirects =
    [ ("blog/2015/10/04/kashmir-and-ladhak-2/index.html", "/blog/2015/10/03/kashmir-and-ladhak-1/")
    ]

-- Site-specific helpers
-- ---------------------

postContext :: Context String
postContext =
    dateField "date" "%d %b %Y" `mappend`
    dropIndexHtml "url" `mappend`
    defaultContext

navItemCtx :: Identifier -> Context String
navItemCtx id =
    field "current" (\i -> if id == itemIdentifier i then return "current" else fail "other")
    `mappend` postContext

navCtx :: Identifier -> Context String
navCtx id = listField "posts" (navItemCtx id) (recentFirst =<< loadAllSnapshots "src/blog/*" "content")

-- General helpers
-- ---------------

removeInitialComponent :: Routes
removeInitialComponent = customRoute $ tailFilePath . toFilePath
    where tailFilePath path = case (splitPath path) of
                                   p:ps -> joinPath ps
                                   []   -> error "empty path"

-- If the URL page's url is of the form "path/index.html", it looks cleaner
-- to use "path/" instead.
dropIndexHtml :: String -> Context a
dropIndexHtml key = mapContext f (urlField key) where
    f url = case splitFileName url of
            (p, "index.html") -> (addTrailingPathSeparator . takeDirectory) p
            _                 -> url


-- Converts a route of the form "blog/yyyy-mm-dd-a-title.ext" to "blog/yyyy/mm/dd/a-title/index.html"
dateTitleRoute :: Routes
dateTitleRoute = customRoute $ joinComponents . splitComponents . toFilePath
    where
      joinComponents (path, y, m, d, title, ext)
        = path </> y </> m </> d </> title </> "index" <.> ext
      splitComponents path
        = let (name, ext) = splitExtension path
           in flatten (takeDirectory name, dateTitleComponents $ takeFileName name, ext)
      flatten (path, (y, m, d, title), ext)
        = (path, y, m, d, title, ext)
      dateTitleComponents p
        = let splitAtHyphen = (\(l, r) -> (l, drop 1 r)) . break (== '-')
              (yyyy, rest)  = splitAtHyphen p
              (mm,   rest') = splitAtHyphen rest
              (dd,   title) = splitAtHyphen rest'
           in (yyyy, mm, dd, title)
