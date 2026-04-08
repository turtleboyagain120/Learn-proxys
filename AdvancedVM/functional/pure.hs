{-# LANGUAGE DeriveGeneric #-}
module Pure where

import Data.Aeson (ToJSON, FromJSON)
import GHC.Generics (Generic)
import qualified Data.ByteString as BS

data FileTree = Dir String [FileTree] | File String BS.ByteString
  deriving (Show, Generic)

instance ToJSON FileTree
instance FromJSON FileTree

buildFileTree :: [String] -> FileTree
buildFileTree paths = Dir "/" [File p mempty | p <- paths]

evalPure :: FileTree -> String
evalPure (Dir n cs) = "Dir " ++ n ++ " (" ++ show (length cs) ++ " items)"
evalPure (File n _) = "File " ++ n

-- Stack/Cabal: stack ghc --package aeson pure.hs

