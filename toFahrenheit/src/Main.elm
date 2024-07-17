module Main exposing (main)

import Browser
import Html exposing (..)
import Html.Attributes exposing (type_)
import Html.Attributes exposing (value)
import Html.Events exposing (onInput)
import String exposing (fromFloat)
import Html.Attributes exposing (style)
import Char exposing (isDigit)

main : Program () Model Msg
main =
    Browser.sandbox
        { init = init
        , view = view
        , update = update
        }


type alias Model = { temperature: String }


init : Model
init = Model ""


type Msg = ToFahrenheit String


update : Msg -> Model -> Model
update msg model =
    case msg of
        ToFahrenheit celcius ->
            { model | temperature = celcius }


view : Model -> Html Msg
view model =
    case String.toFloat model.temperature of 
        Just celcius -> 
            div [] 
            [ input 
                [ type_ "number", 
                value model.temperature, 
                onInput ToFahrenheit ] 
                [],
                text "°C = "
                , span [ style "color" "blue" ] [ text (String.fromFloat (celcius * 1.8 + 32)) ]
            ]
        Nothing -> 
            div []
            [ input 
                [ type_ "number", 
                value model.temperature, 
                onInput ToFahrenheit ] 
                [],
                text "°C = "
                , span [ style "color" "blue" ] [ text "???" ]
            ]
        