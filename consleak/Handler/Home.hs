{-# LANGUAGE TupleSections, OverloadedStrings #-}
module Handler.Home where

import Import


-- | Homepage for the consleak site.
getHomeR :: Handler RepHtml
getHomeR = do
  (formWidget, formEnctype) <- generateFormPost questionForm
  questions <- runDB $ selectList [] [Asc QuestionTitle]
  defaultLayout $ do
    setTitleI MsgWelcome
    $(widgetFile "homepage")


postHomeR :: Handler RepHtml
postHomeR = do
  ((result, _formWidget), _formEnctype) <- runFormPost questionForm
  case result of
    FormSuccess question -> do
      _questionId <- runDB $ insert question
      setMessageI (MsgQuestionPosted question)
      redirect HomeR
    _ -> do
      setMessage "Error with question form"
      redirect HomeR


questionForm :: Form Question
questionForm = renderDivs $
  Question
    <$>                 areq textField     (fieldSettingsLabel MsgQuestionTitle)       Nothing
    <*> (unTextarea <$> areq textareaField (fieldSettingsLabel MsgQuestionDescription) Nothing)


getQuestionR :: QuestionId -> Handler RepHtml
getQuestionR questionId = do
  undefined
