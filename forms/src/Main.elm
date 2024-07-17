module Main exposing (..)
import Html exposing (Html, div, input)
import Html.Attributes exposing (placeholder, type_, value)
import Html.Events exposing (onInput)
import Browser
import Html exposing (text)
import Html.Attributes exposing (style)
import Char exposing (isLower)
import Char exposing (isUpper)
import Char exposing (isDigit)

-- MIN

main : Program () Model Msg
main =
    Browser.sandbox
        { init = init
        , view = view
        , update = update
        }

-- MODEL
type alias Model = 
    { name: String
    , password: String
    , passwordAgain: String
    }

init : Model
init = Model "" "" ""

-- UPDATE
type Msg 
    = Name String
    | Password String
    | PasswordAgain String

update : Msg -> Model -> Model
update msg model =
    case msg of
        Name name -> 
            { model | name = name }

        Password password ->
            { model | password = password }

        PasswordAgain password ->
            { model | passwordAgain = password }

-- VIEW

view : Model -> Html Msg
view model = 
    div []
        [ input 
            [ type_ "text"
            , placeholder "Name"
            , value model.name
            , onInput Name
            ]
            [],
            input 
            [ type_ "password"
            , placeholder "Password"
            , value model.password
            , onInput Password
            ]
            [],
            input
            [ type_ "password"
            , placeholder "Re-enter Password"
            , value model.passwordAgain
            , onInput PasswordAgain
            ]
            []
            ,
            viewValidation model
        ] 

viewValidation : Model -> Html msg
viewValidation model =
    if model.password /= model.passwordAgain then div [ style "color" "red" ] [ text "Passwords do not match!" ]
    else if String.length model.password < 8 then div [ style "color" "red" ] [ text "Password is too short!" ]
    else if not (String.any isDigit model.password) then div [ style "color" "red" ] [ text "Password must contain digits" ]
    else if not (String.any isUpper model.password) then div [ style "color" "red" ] [ text "Password must contain uppercase" ]
    else if not (String.any isLower model.password) then div [ style "color" "red" ] [ text "Password must contain lowercase" ]
    else div [ style "color" "green" ] [ text "OK" ]
