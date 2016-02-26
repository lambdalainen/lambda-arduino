module Handler.TestBlink where

import Import
import System.Hardware.Arduino
import Util
import qualified Data.HashMap.Strict as M

getTestBlinkR :: Handler Value
getTestBlinkR = do
  runOnBoard blink
  return $ toValue []

blink :: IO ()
blink = withArduino' $ do
  let led = digital 13
  setPinMode led OUTPUT
  forever $ do digitalWrite led True
               delay 1000
               digitalWrite led False
               delay 1000

toValue :: [(Text, Text)] -> Value
toValue = toJSON . M.fromList