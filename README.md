Warning: This is not the first nor the last checkpoint.  If
you're in the middle of the tutorial, just ignore this warning.
If you've just arrived here, you'll probably want to take a look
at either one of these checkpoints.

Yesod tutorial from 4th São Paulo Haskellers Meeting
====================================================

Welcome!  This is the repo of the tutorial that was presented on
the [4th São Paulo Haskellers Meeting](https://plus.google.com/events/c9r4tblnvdfnm2qkvtpjj96v8m8)
by Felipe Lessa (@meteficha).

To prepare your environment, you'll need to:

  1. Install the [Haskell Platform](http://www.haskell.org/platform/).

  2. Update your Cabal database by running `cabal update`.

  3. Install the [Yesod Platform](http://www.yesodweb.com/)
  version 1.2 by running `cabal install yesod-platform-1.2.0.1
  persistent-sqlite esqueleto`.  Note that by the time you follow
  these instructions there may be a more recent version of the
  Yesod Platform, but this tutorial has been written with this
  one mind.

  4. Clone this repo to your machine.

  5. Finally, checkout the first checkpoint by using
  `git checkout -f checkpoint-00`.


How to follow this tutorial
===========================

This tutorial has the concept of _checkpoints_.  Each checkpoint
is a git branch.  You'll use the checkpoints in order to advance
through the tutorial.  At all times, just check the file
`TODO.md` in order to see what is your current task.

To go to the first checkpoint, just run `git checkout -f
checkpoint-00`.  Now open `TODO.md` and continue from there =).

After completing a checkpoint's task, you may want to compare
your code with the solution in the repo.  For example, if you are
on `checkpoint-07`, you should run `git diff checkpoint-08` in
order to see how your solution differs from the repo's one.

If you're satisfied with your solution and want to follow to the
next checkpoint, then commit your progress for future reference
using `git commit -a -m 'My progress'` and checkout the next
checkpoint using `git checkout -f checkpoint-XX`, where `XX` is
the number of the next checkpoint.  (Use `git branch` to see your
current checkpoint.)  Your modifications will be thrown away and
you'll go on with the tutorial's code.
