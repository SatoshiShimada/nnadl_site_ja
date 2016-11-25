#!/usr/bin/env runhaskell
{-# LANGUAGE OverloadedStrings #-}

import Control.Monad
import Data.List
import qualified Data.Text as T
import qualified Data.Text.IO as T
import System.Environment

main :: IO ()
main = do
  argv <- getArgs
  mapM_ process argv

process :: FilePath -> IO ()
process fn = do
  con <- T.readFile fn
  T.writeFile ("offline-" ++ fn) $ T.unlines $ filter goodLine $ T.lines con

  where

    goodLine :: T.Text -> Bool
    goodLine = not . T.isInfixOf "https://cdn.mathjax.org/mathjax/latest/MathJax.js"
