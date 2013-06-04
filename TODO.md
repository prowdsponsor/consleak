Checkpoint 00
=============

Welcome to checkpoint 00!  Your task is to initialize the repo
with Yesod's scaffold.  To do so you must have the Yesod Platform
installed as explained on the `README.md`.

To create the scaffold run `yesod init`.  You'll prompted for the
project name (say, `consleak`) and for the project's backend
database (we'll use SQLite).

After creating the scaffold, step into the project's directory
(`cd consleak`) and initialize Yesod's development server by
running `yesod devel`.  If this command fails because of missing
dependencies, use `cabal install --only-dependencies`.

Now point your browser to <http://localhost:3000/>.
Congratulations, your scaffold is working =).

Take a look at the files that were created and continue with
checkpoint 01 by running `git checkout -f checkpoint-01`.
