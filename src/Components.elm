module Components exposing (..)

import Html exposing (Html)
import Html.Attributes as Attr


type ButtonSize
    = Sm
    | Lg
    | Xl


type Color
    = Indigo
    | Blue


fancyButton : List (Html msg) -> ButtonSize -> Color -> Html msg
fancyButton text size color =
    Html.div [ Attr.class "" ] text
