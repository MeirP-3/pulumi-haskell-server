{-# LANGUAGE OverloadedStrings #-}

module Main where
import Network.Wai
import Network.HTTP.Types
import Network.Wai.Handler.Warp (run)
import qualified Data.ByteString.Lazy.Char8 as C (pack)

formatHtml:: Request -> String
formatHtml request = 
    "<html><body>" ++
    "<p> Method: " ++ (show $ requestMethod request) ++ "</p>" ++
    "<p> HTTP Version: " ++ (show $ httpVersion request) ++ "</p>" ++
    "<p> Headers: " ++ (show $ requestHeaders request) ++ "</p>" ++
    "<p> Your IP: " ++ (show $ remoteHost request) ++ "</p>" ++
    "<p> Path: " ++ (show $ pathInfo request) ++ "</p>" ++
    "<p> Query string: " ++ (show $ queryString request) ++ "</p>" ++
    "<p> Host: " ++ (show $ requestHeaderHost request) ++ "</p>" ++
    "</body></html>"

app :: Application
app request respond = do
    putStrLn "Got a request!!"
    respond $ responseLBS
        status200
        [("Content-Type", "text/html")]
        (C.pack $ formatHtml request)

main :: IO ()
main = do
    putStrLn $ "http://localhost:80/"
    run 80 app
