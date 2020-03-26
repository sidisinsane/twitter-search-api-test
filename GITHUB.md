# [Adding an existing project to GitHub using the command line](https://help.github.com/en/github/importing-your-projects-to-github/adding-an-existing-project-to-github-using-the-command-line)

1. Create a new repository on GitHub. To avoid errors, do not initialize the new repository with README, license, or gitignore files. You can add these files after your project has been pushed to GitHub.

2. Open Terminal and change the current working directory to your local project. Then initialize the local directory as a Git repository.
   ```bash
   git init
   ```

3. Add the files in your new local repository. This stages them for the first commit.
   ```bash
   git add .
   ```

4. Commit the files that you've staged in your local repository.
   ```bash
   git commit -m "initial commit"
   ```

5. At the top of your GitHub repository's Quick Setup page, click  to copy the remote repository URL.
   Copy remote repository URL field

6. In Terminal, add the URL for the remote repository where your local repository will be pushed.
   Set the new remote:
   ```bash
   git remote add origin [remote repository URL]
   ```
   Verify the new remote URL:
   ```bash
   git remote -v
   ```
   Push the changes in your local repository to GitHub:
   ```bash
   git push -u origin master
   ```
