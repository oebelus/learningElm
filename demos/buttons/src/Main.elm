module Main exposing (..)
import Browser

import Html exposing (Html, div, button, text)
import Html.Events exposing (onClick)

-- MAIN
main : Program () Model Msg
main =
    Browser.sandbox
        { init = init
        , view = view
        , update = update
        }

-- MODEL
type alias Model = Int

init : Model
init =
    0

-- UPDATE 
type Msg = Increment | Decrement | Reset | Ten

update : Msg -> Model -> Model
update msg model = 
    case msg of 
        Increment ->
            model + 1

        Decrement -> 
            model - 1

        Reset ->
            0

        Ten ->
            model + 10

-- VIEW
view : Model -> Html Msg
view model =
    div []
        [ button [ onClick Decrement ] [ text "-" ] 
        , div [] [ text (String.fromInt model) ]
        , button [ onClick Increment ] [ text "+" ]
        , button [ onClick Reset ] [ text "reset" ]
        , button [ onClick Ten ] [ text "+10" ]
        ]
