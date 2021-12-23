module Page.Index exposing (Data, Model, Msg, page)

import DataSource exposing (DataSource)
import Head
import Head.Seo as Seo
import Html exposing (Html)
import Html.Attributes exposing (class)
import Markdown.Block exposing (Block)
import Markdown.Parser exposing (deadEndToString)
import Markdown.Renderer exposing (defaultHtmlRenderer)
import Page exposing (Page, StaticPayload)
import Pages.PageUrl exposing (PageUrl)
import Pages.Url
import Shared
import View exposing (View)


type alias Model =
    ()


type alias Msg =
    Never


type alias RouteParams =
    {}


page : Page RouteParams Data
page =
    Page.single
        { head = head
        , data = data
        }
        |> Page.buildNoState { view = view }


data : DataSource Data
data =
    DataSource.succeed ()


head :
    StaticPayload Data RouteParams
    -> List Head.Tag
head static =
    Seo.summary
        { canonicalUrlOverride = Nothing
        , siteName = "elm-pages"
        , image =
            { url = Pages.Url.external "TODO"
            , alt = "elm-pages logo"
            , dimensions = Nothing
            , mimeType = Nothing
            }
        , description = "TODO"
        , locale = Nothing
        , title = "Elm pages tailwind starter" -- metadata.title -- TODO
        }
        |> Seo.website


type alias Data =
    ()


deadEndsToString deadEnds =
    deadEnds
        |> List.map Markdown.Parser.deadEndToString
        |> String.join "\n"


render renderer markdown =
    case
        markdown
            |> Markdown.Parser.parse
            |> Result.mapError deadEndsToString
            |> Result.andThen (\ast -> Markdown.Renderer.render renderer ast)
    of
        Ok rendered ->
            Html.div [] rendered

        Err errors ->
            Html.text errors


markdownContentRendered : Html msg
markdownContentRendered =
    render defaultHtmlRenderer "# Hello worldsss"


view :
    Maybe PageUrl
    -> Shared.Model
    -> StaticPayload Data RouteParams
    -> View Msg
view maybeUrl sharedModel static =
    { title = "Starter page"
    , body =
        [ Html.div
            [ class "myButton"
            ]
            [ markdownContentRendered ]
        ]
    }
