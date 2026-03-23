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

    match ("src/covers/**.jpg") $ do
        route   $ removeInitialComponent
        compile $ loadImage

    match ("src/blog/**.jpg" .||. "src/blog/**.png") $ do
        route   $ composeRoutes removeInitialComponent
                                dateTitleRoute
        compile $ loadImage >>= ensureFitCompiler 10000 480

    match "src/css/*" $ do
        route   $ removeInitialComponent
        compile compressCssCompiler

    match ("src/index.md" .||. "src/resume.md") $ do
        route   $ composeRoutes removeInitialComponent $
                                setExtension "html"
        compile $ do
            id <- getUnderlying
            pandocCompiler
                >>= loadAndApplyTemplate "templates/default.html" ((navCtx id) <> defaultContext)

    match "src/blog/*/index.md" $ do
        route   $ composeRoutes removeInitialComponent $
                  composeRoutes dateTitleRoute
                                (setExtension "html")
        compile $ do
            id <- getUnderlying
            pandocCompiler
                >>= saveSnapshot "content"
                >>= loadAndApplyTemplate "templates/comments.html" postContext
                >>= loadAndApplyTemplate "templates/default.html"  ((navCtx id) <> postContext)


    create ["atom.xml"] $ do
        route idRoute
        compile $ do
            let feedCtx = postContext
            posts <- recentFirst =<< loadAllSnapshots "src/blog/**/index.md" "content"
            renderAtom atomCfg feedCtx posts

    match "templates/*" $ compile templateBodyCompiler

atomCfg = FeedConfiguration
    { feedTitle       = "Nishant's Blog"
    , feedDescription = "Just some ramblings"
    , feedAuthorName  = "Nishant Rodrigues"
    , feedAuthorEmail = "no-reply@example.com" --- don't want to encourage spam.
    , feedRoot        = "https://nishantjr.github.io/"
    }

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
navCtx id = listField "posts" (navItemCtx id) (recentFirst =<< loadAllSnapshots "src/blog/**/index.md" "content")

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


-- Converts a route of the form "blog/yyyy-mm-dd-a-title/index.ext" to "blog/yyyy/mm/dd/a-title/index.rest"
dateTitleRoute :: Routes
dateTitleRoute = customRoute $ f
  where
    f id = base </> yyyy </> mm </> dd </> title </> rest
      where
        (base, mid, rest) = intoThree $ splitPath $ toFilePath id
        (yyyy, mm, dd, title) = dateTitleComponents mid

        intoThree (base:mid:rest) = (base, mid, joinPath rest)
        intoThree _ = error
          "expected path of the form: 'blog/yyyy-mm-dd-a-title/a/s/d/f/index.ext'"

        dateTitleComponents p
          = let splitAtHyphen = (\(l, r) -> (l, drop 1 r)) . break (== '-')
                (yyyy, rest)  = splitAtHyphen p
                (mm,   rest') = splitAtHyphen rest
                (dd,   title) = splitAtHyphen rest'
             in (yyyy, mm, dd, title)
