module Main exposing (main)

import Browser
import Html exposing (..)
import Html.Attributes exposing (type_)
import Html.Attributes exposing (value)
import Html.Events exposing (onInput)
import Html.Attributes exposing (style)

main : Program () Model Msg
main =
    Browser.sandbox
        { init = init
        , view = view
        , update = update
        }


type alias Model = { 
    temperature: String,
    distance: String
    }


init : Model
init = Model "" "" 


type Msg 
    = ToFahrenheit String
    | ToCelcius String
    | ToMeters String


update : Msg -> Model -> Model
update msg model =
    case msg of
        ToFahrenheit fahrenheit ->
            { model | temperature = fahrenheit }

        ToCelcius celcius ->
            { model | temperature = celcius }

        ToMeters meters ->
            { model | distance = meters }

view : Model -> Html Msg
view model =
    div []
        [ case String.toFloat model.temperature of 
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
                    onInput ToFahrenheit,
                    style "border-color" "red" ] 
                    [],
                    text "°C = "
                    , span [ style "color" "blue" ] [ text "???" ]
                ]
        , case String.toFloat model.distance of
            Just inch ->
                div []
                [ input
                    [ type_ "number",
                    value model.distance,
                    onInput ToMeters ]
                    [],
                    text " m = "
                    , span [ style "color" "blue" ] [ text (String.fromFloat (inch * 39.3701) ) ]
                ]
            Nothing ->
                div []
                [ input
                    [ type_ "number"
                    , value model.distance
                    , onInput ToMeters,
                    style "border-color" "red" ] 
                    [],
                    text " m = "
                    , span [ style "color" "blue" ] [ text "???" ]
                ]
            ]