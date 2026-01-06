module Main (main) where

import qualified Zcat

import qualified Data.ByteString as BS

main :: IO ()
main = do
    inputBytes :: BS.ByteString <- Zcat.stdin2bytes
    let outputBytes :: BS.ByteString = Zcat.decompressBytes inputBytes
    Zcat.bytes2stdout outputBytes
