Checkpoint 03
=============

You may have noticed that we have been using messages everywhere
but just with English.  For a single language there isn't much
value in using messages, it's a wasted hassle.  So on this
checkpoint we'll add support for Portuguese.

First of all, create a copy of `messages/en.msg` as `messages/pt.msg`.

    $ cp messages/en.msg messages/pt.msg

Now translate those messages from English to Portuguese.

    Welcome: Bem-vindo ao Consleak!

    QuestionTitle: Sua pergunta
    QuestionDescription: Por favor elabore
    QuestionSubmit: Fazer pergunta!

    QuestionPosted question: Sua pergunta "#{questionTitle question}" foi feita!

    PostedQuestions: Perguntas feitas

    PostedAnswers: Respostas dadas
    PostAnAnswer: Dar uma resposta

    AnswerText: Sua resposta

    AnswerPosted: Muito obrigado!  Sua resposta foi dada!

    BackToHomepage: Voltar à página inicial

If you're an attentive reader, you'll note that there has been
another change besides the translations themselves.  Let's take a look:

    -- en.msg
    QuestionPosted question@Question: Your question "#{questionTitle question}" has been posted!

    -- pt.msg
    QuestionPosted question: Sua pergunta "#{questionTitle question}" foi feita!

The English file is the master, so every argument given to a
message must have an explicit type.  On the other hand, it is not
necessary to specify the type on the Portuguese file, just the
argument name.  Note, however, that it _is_ necessary to use the
same argument name.

And that's it!  If you set your browser's primary language to
Portuguese you should see the right message file being used.

Actually, there's still one more thing.  `yesod-form` has some
built-in messages that need to be translated as well.
Unfortunately, currently you need to manually wrap things up.
Head to the `Foundation` module and:

    -- at the header
    import Yesod.Form.I18n.English
    import Yesod.Form.I18n.Portuguese

    -- line 152
    instance RenderMessage App FormMessage where
        renderMessage _ = go
          where
            go ("en":_) = englishFormMessage
            go ("pt":_) = portugueseFormMessage
            go (_:rest) = go rest
            go []       = englishFormMessage -- default language

Congratulations! You made it to the end of checkpoint 03. When
you're ready, continue by running `git checkout -f checkpoint-04`.
