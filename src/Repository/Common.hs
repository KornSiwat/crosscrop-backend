module Repository.Common where

import qualified ClassyPrelude.Yesod as P

import           Error.Definition

import           UnliftIO.Exception  (catch)

runDB :: P.YesodPersist site
       => P.ReaderT (P.YesodPersistBackend site) (P.HandlerFor site) a
       -> P.HandlerFor site (Either Error a)
runDB x = do
    catch
        (Right <$> P.runDB x)
        (\(P.SomeException _) -> return $ Left ToBeDefinedError)

