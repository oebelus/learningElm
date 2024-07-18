module Main exposing (main)

import Browser
import Html exposing (..)
import Random
import Html.Events exposing (onClick)
import Html.Attributes exposing (src)
import Html.Attributes exposing (style)


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
        
type Numbers = One | Two | Three | Four | Five | Six

type alias Model = 
    { one : Numbers
    , two : Numbers
    }
    
init : () -> ( Model, Cmd Msg )
init () =
    ( Model One One
    , Cmd.none
    ) 


type Msg
    = Roll
    | NewFaces Numbers Numbers

generateNumber : Random.Generator Numbers
generateNumber = Random.uniform One [ Two, Three, Four, Five, Six ]

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Roll ->
            let
                generator = Random.map2 NewFaces generateNumber generateNumber
            in
            ( model, Random.generate identity generator )

        NewFaces a b ->
            ( Model a b, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none


view : Model -> Html Msg
view model =
    div [ ]
        [ button [ onClick Roll, style "fontSize" "26px", style "margin-left" "27%", style "margin-top" "150px", style "margin-bottom" "150px" ] [ text "Generate a number from 1 to 6" ] 
        , div [ style "display" "flex"] [
        img [src ("dices/" ++ (numbersToString model.one) ++ ".png")] []
        , img [src ("dices/" ++ (numbersToString model.two) ++ ".png")] []]]

numbersToString : Numbers -> String
numbersToString number =
    case number of
        One -> "one"
        Two -> "two"
        Three -> "three"
        Four -> "four"
        Five -> "five"
        Six -> "six"