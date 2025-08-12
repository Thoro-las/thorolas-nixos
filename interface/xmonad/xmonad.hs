import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks

main = xmonad =<< xmobar myConfig

myConfig = docks def {
        modMask = mod4Mask,
        terminal = "kitty"
    }
