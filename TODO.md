Checkpoint 01
=============

Consleak is going to be an extremely minimal StackOverflow clone.

We'll start by providing a form where questions may be posted.
First of all, we'll create an entity for questions.  Open the
file `config/models` on your text editor and add the
following code to the end of it:

    Question
        title       Text
        description Text

Now, on the `Handler.Home` module and on the `homepage`
templates, add a list of currently asked questions and a form to
post a new question.

    -- On Handler.Home
    getHomeR :: Handler RepHtml
    getHomeR = do
      (formWidget, formEnctype) <- generateFormPost questionForm
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


    -- On homepage.hamlet
    <h1>_{MsgWelcome}

    <form method=post action=@{HomeR} enctype=#{formEnctype}>
      ^{formWidget}
      <input type="submit" value=_{MsgQuestionSubmit}>


    -- On en.msg
    Welcome: Welcome to Consleak!

    QuestionTitle: Your question
    QuestionDescription: Please elaborate

    QuestionPosted question@Question: Your question "#{questionTitle question}" has been posted!


I've reused the `sampleForm` that came with the scaffold but most
other things have been thrown away.  Some notes:

  - `getHomeR` just generates the markup for the `questionForm`
    and uses the `homepage` widget.  It also uses `setTitleI`
    which will set the title of the page using the `MsgWelcome`
    message (see `en.msg`).  Check `config/routes` to see which
    path will trigger `getHomeR`.

  - `postHomeR` is called for POSTs on the `HomeR` route.  It
    runs the `questionForm` as well but also tries to parse it
    from the HTTP request.  If successful, it inserts the
    question on the database, uses `setMessageI` to set a message
    for the next route and redirects to `HomeR`.  Since a
    redirect will lead to an HTTP GET, this means that the
    user-agent will land on `getHomeR`.

  - `questionForm` defines a form that, when successfully filled,
    is represented by a `Question`, the entity we created above.
    It uses applicative-style to glue the two fields (`textField`
    and `textareaField`) into a single form.

(I've glossed over a lot of details.  The purpose of this
tutorial isn't to explain everything in detail but to give you a
direction to follow when learning to use Yesod.)


Finally, we'll add a list of posted questions to the homepage.

    -- On Home.hs
    getHomeR = do
      ...form...
      questions <- runDB $ selectList [] [Asc QuestionTitle]
      ...defaultLayout...


    -- On homepage.hamlet
    <h2>_{MsgPostedQuestions}
    <ul .questions>
      $forall Entity _questionId question <- questions
        <li>#{questionTitle question}


    -- On en.msg
    PostedQuestions: Posted questions


Notes:

  - `selectList` takes as arguments a list of filters and a list
    of options.  We chose to order by ascending order of question
    title.

  - The `$forall` construct is part of the Hamlet language and
    introduces an iteration over a list.  We also use pattern
    matching to separate the Question ID on the database from the
    Question itself.

  - The `#{...}` construct interpolates the result of a Haskell
    expression on the template.  You have already seen it being
    used on the `QuestionPosted` message.


Congratulations!  You made it to the end of checkpoint 01.  You
may want to `git commit -am "My work"` in order to save your
modifications for future reference or `git diff checkpoint-02` to
see how your code differs from the one of the tutorial.

If you're ready, continue by running `git checkout -f
checkpoint-02`.
