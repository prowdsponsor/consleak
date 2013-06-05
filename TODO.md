Checkpoint 02
=============

We already have a way of adding questions.  But how about answers?

As before, we'll start by adding a new entity to `config/models`:

    Answer
        for  QuestionId
        text Text

Besides the answer itself, we'll store a reference to the
Question this Answer is answering.  We do this by creating a
field whose type is the ID of the referred entity.  Persistent
will create a foreign key for us when migrating the database.

To be able to add answers, we'll create a new route for the
questions.  Open the `config/routes` file and add the following
line:

    /question/#QuestionId QuestionR GET

If you just do the above, you'll see the following error:

    Application.hs:29:1: Not in scope: `getQuestionR'

It tells you that you need to implement a `getQuestionR` function
since you've defined a route QuestionR that supports GET
requests.

So move on to `Handler.Home` and add:

    getQuestionR :: QuestionId -> Handler RepHtml
    getQuestionR questionId = do
      undefined

We'll define it later.  Also change `homepage.hamlet` to add a
link to every question there:

    <ul .questions>
      $forall Entity questionId question <- questions
        <li>
          <a href=@{QuestionR questionId}>
            #{questionTitle question}

Check <http://localhost:3000/> again.  You should see a link on
each question you've posted leading to a page that just yells
`Prelude.undefined`.

With this in place, let's create a new template `question` by
creating a `templates/question.hamlet` file:

    -- templates/question.hamlet
    <h1>#{questionTitle question}
    <p>#{questionDescription question}


    -- Handler.Home
    getQuestionR :: QuestionId -> Handler RepHtml
    getQuestionR questionId = do
      question <- runDB $ get404 questionId
      defaultLayout $ do
        setTitleI (questionTitle question)
        $(widgetFile "question")

To add support for answering questions, we'll need to create
another form similar to `questionForm`:


    -- Handler.Home
    getQuestionR :: QuestionId -> Handler RepHtml
    getQuestionR questionId = do
      ...runDB...
      (formWidget, formEnctype) <- generateFormPost (answerForm questionId)
      ...defaultLayout...

    postQuestionR :: QuestionId -> Handler RepHtml
    postQuestionR questionId = do
      ((result, _formWidget), _formEnctype) <- runFormPost (answerForm questionId)
      case result of
        FormSuccess answer -> do
          _answerId <- runDB $ insert answer
          setMessageI MsgAnswerPosted
          redirect (QuestionR questionId)
        _ -> do
          setMessage "Error with question form"
          redirect (QuestionR questionId)

    answerForm :: QuestionId -> Form Answer
    answerForm questionId = renderDivs $
      Answer
        <$> pure questionId
        <*> (unTextarea <$> areq textareaField (fieldSettingsLabel MsgAnswerText) Nothing)


    -- config/routes
    /question/#QuestionId QuestionR GET POST


    -- en.msg
    PostAnAnswer: Post an answer
    AnswerText: Your answer
    AnswerPosted: Thank you!  Your answer has been posted!


    -- question.hamlet
    <h1>_{MsgPostAnAnswer}
    <form method=post action=@{QuestionR questionId} enctype=#{formEnctype}>
      ^{formWidget}
      <input type="submit" value=_{MsgQuestionSubmit}>

Note that now `answerForm` is a function since it takes the
`QuestionId` as argument.

Finally, let's display the answers as well:

    --- Handler.Home
    getQuestionR questionId = do
      (question, answers) <-
        runDB $ (,) <$> get404 questionId
                    <*> selectList [ AnswerFor ==. questionId ] []
      ...form...
      ...defaultLayout...


    -- en.msg
    PostedAnswers: Posted answers


    -- question.hamlet
    $if not (null answers)
      <h1>_{MsgPostedAnswers}
      <ul>
        $forall Entity _answerId answer <- answers
          <li>#{answerText answer}

Here we use another Hamlet construct, `$if`, which does what you
expect it to.


Congratulations!  You made it to the end of checkpoint 02.
When you're ready, continue by running `git checkout -f
checkpoint-03`.
