module Zcat (
    stdin2bytes,
    bs2lazy,
    inflate,
    lazy2bs,
    bytes2stdout,
    decompressBytes, -- Added this to exposed functions
) where

import qualified Data.ByteString as BS
import qualified Data.ByteString.Lazy as LBS

import qualified Codec.Compression.GZip as GZip

stdin2bytes :: IO BS.ByteString
stdin2bytes = BS.getContents

bs2lazy :: BS.ByteString -> LBS.ByteString
bs2lazy = LBS.fromStrict

inflate :: LBS.ByteString -> LBS.ByteString
inflate = GZip.decompress

lazy2bs :: LBS.ByteString -> BS.ByteString
lazy2bs = LBS.toStrict

bytes2stdout :: BS.ByteString -> IO ()
bytes2stdout = BS.putStr

-- New pure helper function for decompressing ByteStrings
decompressBytes :: BS.ByteString -> BS.ByteString
decompressBytes = lazy2bs . inflate . bs2lazy
