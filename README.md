Grunt-Tusk
==========

[GruntJS](http://gruntjs.com) based build system for frontend web projects.

Features
--------

* Write your code using [CoffeeScript](http://coffeescript.org) and have it compile into CommonJS modules (this allows you to easily share code between browser and node)
* Style your web application using [SASS](http://sass-lang.com) (built-in support for [Compass](http://compass-style.org), [Twitter bootstrap](http://twitter.github.com/bootstrap/) and [Font Awesome](http://fortawesome.github.com/Font-Awesome/))
* Use [Jade](http://jade-lang.com) for all of your templates (static pages compile to html, and dynamic templates compile to javascript)
* Write a multi-lingual application using [I18n-js](http://github.com/fnando/i18n-js)
* Automatically live reload your browser when files are changed
* Use third-party packages using [bower](https://github.com/twitter/bower)
* Test your code using [mocha](http://mochajs.org/), chai, sinon and more.


Directory Structure
--------------------

```
app/
  coffee/
  i18n/
    en.coffee
    he.coffee
    ...
  images/
  pages/ - static pages (jade -> html)
    index.jade - compiled to index.html
    _layout.jade - files starting with _ are ignored, useful for layouts and partials
    ...
  stylesheets/
  templates/
    index.jade - compiled to JS code and accessable via JST["index"]
    ...

test/
  test.jade - test runner template
  *_spec.coffee - test files
  
build/ - production output
public/ - development output

```
 
Output - Development
---------------------
```
public/
  index.html

  vendor.js
  templates.js
  app.js
  i18n/
    en.js
    he.js
    ...
    
  app.css
  images/
  fonts/
  
  test.html
  test.js
  test_vendor.js

```

Output - Production
--------------------
```
build/
  index.html
  app.js - a combined version for vendor.js, templates.js, i18n/en.js and app.js
  app
  i18n/
    he.js
    ...
    
  app.css
  images/
  fonts/
```
  
Configuration
------------

* Add tusk to your package.json:

```javascript
  "dependencies": {
    "grunt": "~0.4.0",
    "grunt-tusk": "~0.0.1"
  },
```

* Add the following to your Gruntfile.coffee:

```coffee
module.exports = (grunt) ->

  tusk = require 'grunt-tusk'
  tusk.initialize grunt,
    scripts:
      vendor: [
        'components/jquery/jquery.js'
        'components/underscore/underscore.js'
        'components/backbone/backbone.js'
        'components/i18n-js/vendor/assets/javascripts/i18n.js'
        'components/marionette/lib/backbone.marionette.js'
        'components/bootstrap-sass/js/bootstrap-tooltip.js'
        'components/bootstrap-sass/js/bootstrap-affix.js'
        'components/bootstrap-sass/js/bootstrap-alert.js'
        'components/bootstrap-sass/js/bootstrap-button.js'
        'components/bootstrap-sass/js/bootstrap-carousel.js'
        'components/bootstrap-sass/js/bootstrap-collapse.js'
        'components/bootstrap-sass/js/bootstrap-dropdown.js'
        'components/bootstrap-sass/js/bootstrap-modal.js'
        'components/bootstrap-sass/js/bootstrap-popover.js'
        'components/bootstrap-sass/js/bootstrap-scrollspy.js'
        'components/bootstrap-sass/js/bootstrap-tab.js'
        'components/bootstrap-sass/js/bootstrap-transition.js'
        'components/bootstrap-sass/js/bootstrap-typeahead.js'
        ]
      test_vendor: [
        'components/mocha/mocha.js',
        'components/chai/chai.js',
        'components/sinon.js/sinon.js',
        'components/sinon-chai/lib/sinon-chai.js'
        ]
    copy: [
      { source: 'components/bootstrap-sass/img', dest: 'images' }
      { source: 'components/font-awesome/font', dest: 'fonts' }
    ]


```

* Add the following packages to bower's component.json file:

```javascript
{
  "dependencies": {
    "bootstrap-sass": "2.2.2",
    "mocha": "1.8.1",
    "chai": "1.4.2",
    "sinon.js": "*",
    "sinon-chai": "git://github.com/domenic/sinon-chai#2.3.1",
    "font-awesome": "3.0.2",
    "underscore": "1.4.4",
    "backbone": "0.9.10",
    "marionette": "1.0.0-rc5",
    "i18n-js": "git://github.com/fnando/i18n-js"
  }
}

```
  
Template
--------
See [grunt-tusk-template](https://github.com/elentok/grunt-tusk-template) for a basic template to get start faster.
  
  

