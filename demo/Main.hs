import Control.Concurrent.Async
import Control.Retry
import Network.HTTP.Req
import Turtle

waitForServer :: IO ()
waitForServer = do
  let httpOptions =
        defaultHttpConfig
          { httpConfigRetryJudgeException = \_ _ -> True,
            -- microseconds * number of retries
            httpConfigRetryPolicy = constantDelay 1000000 <> limitRetries 30
          }

  _ <- runReq httpOptions $ do
    result <- req GET (http "localhost" /: "foo") NoReqBody bsResponse (port 3000)
    let code = (responseStatusCode result :: Int)
    return code

  pure ()

main :: IO ()
main = do
  sh $ do
    pr <- fork $ proc "cabal" ["v2-run", "async-hs"] empty
    liftIO waitForServer
    liftIO $ cancel pr
