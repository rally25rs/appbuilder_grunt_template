# Introduction

This is a sample of a way to structure a project to use the Telerik AppBuilder CLI tools with CoffeeScript and LESS.

# Using this template

## First-time setup

1. Install [node.js](http://nodejs.org)
1. Install Grunt globally `npm install -g grunt-cli`
1. Install Telerik AppBuilder globally `npm install -g appbuilder`
1. Clone this repository and rename it to whatever you like (See notes below).
1. Change the `git remote` to point to your own GitHub repository.
1. Open `package.json` and edit the `name`, `description`, `author`, etc.
1. Run `npm install` to fetch the dependencies.
1. Run `grunt init` to create the initial AppBuilder project in the `\app` directory.
1. Open `app\.abproject` and edit the `name`, `projectVersion`, `AppIdentifier`, etc.
1. Replace this file (README.md) with whatever documentation makes sense for your project.

## Cloning the repo

This can be a little tricky...
If you are using GitHub, I recommend:

* Make a new repo on GitHub with your app name. For example `super-app`
* In a Git command line, clone the template to a directoy with your app name:

    git clone https://github.com/rally25rs/appbuilder_grunt_template.git super-app

* Change the remote from this template to your own repo:

    git remote set-url origin https://github.com/your-user-name/super-app.git

* Push!

    git push

##Build

1. In Sublime Text's main menu, choose `Project > Open Project...` and choose this directory.
1. Edit the code in the `\src` directory.
1. Run build and tests on command line using the command `grunt`, or `ctrl-b` in Sublime Text (You may have to change your build tool to "Grunt" first).
1. When running Telerik AppBuilder commands, run them from the `\app` directory, or with the parameter `--path app`. For example, to run the simulator:

    appbuilder simulate --path app
	
## Grunt tasks

* `grunt init` - Runs `appbuilder create app` to create the initial `\app` directory structure and .abproject file.
* `grunt clean` - Removes generated content (.html, .js, .css) from the `\app` directory.
* `grunt` - (default task) Performs a `clean` then builds CoffeeScript and LESS into the `\app` directory, then runs the Jasmine tests.

# Layout

    \app                // The actual AppBuilder CLI project. CoffeeScript and LESS build into here
	\src                // The source code you edit
	 |- \App_Resources  // App icons. Copied to \app\App_Resources during build
	 |
	 |- \data           // Any misc data. Copied to \app\data during build
	 |
	 |- \scripts        // The js and coffescript files that make up your app
	 |   |- *.coffee    // Coffee files are compiled to .js
	 |   |- *.js        // js files are directly copied to \app\scripts
	 |
	 |- \styles         // The css and less files that make up your app
	 |   |- *.less      // Less files are compiled to .css
	 |   |- *.css       // css files are directly copied to \app\styles
	 |
	 |- \views
	 |   |- *.jade      // The Jade views that make up your app
	 |
	 |- *.html          // The views that make up your app when not using Jade
	 |- index.jade      // optional main Jade file that includes all others
	\tests              // Jasmine tests
	 |- \generated      // Coffeescript tests compile to js in this folder before being run
	 |- *.spec.coffee
