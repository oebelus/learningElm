module Main exposing (..)

import Browser
import Html exposing (Html, input, div, text)
import Html.Attributes exposing (placeholder, value)
import Html.Events exposing (onInput)

-- MAIN
main : Program () Model Msg
main =
    Browser.sandbox {
        init = init,
        update = update,
        view = view
    }

-- MODEL
type alias Model = { content : String }

init : Model
init = { content = "" }

-- UPDATE
type Msg = Change String 

update : Msg -> Model -> Model
update msg model = 
    case msg of
        Change newContent ->
            { model | content = newContent }

-- VIEW

view : Model -> Html Msg
view model =
    div []
        [ input [ placeholder "Text to reverse", value model.content, onInput Change ] []
        , div [] [ text (String.reverse model.content) ]
        , div [] [ text ( String.fromInt (String.length model.content) ) ]
        ]