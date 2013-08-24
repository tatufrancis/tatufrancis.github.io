module.exports = (grunt) ->

  grunt.initConfig
    pkg: grunt.file.readJSON("package.json")

    watch:
      jade:
        files: '**/*.jade'
        tasks: ['jade']
      compass:
        files: '**/*.scss'
        tasks: ['compass', 'autoprefixer']
      coffee:
        files: '**/*.coffee'
        tasks: ['coffee']

    jade:
      build:
        files:
          'pages/home.html':              ['src/jade/home.jade']
          'pages/layout-a.html':          ['src/jade/layout-a.jade']
          'pages/layout-b.html':          ['src/jade/layout-b.jade']
          'pages/layout-c.html':          ['src/jade/layout-c.jade']
          'pages/grid.html':              ['src/jade/grid.jade']
          'pages/helpers.html':           ['src/jade/helpers.jade']
          'pages/typography.html':        ['src/jade/typography.jade']
          'pages/navigation.html':        ['src/jade/navigation.jade']
          'pages/buttons.html':           ['src/jade/buttons.jade']
          'pages/boxes.html':             ['src/jade/boxes.jade']
          'pages/messages.html':          ['src/jade/messages.jade']
          'pages/tables.html':            ['src/jade/tables.jade']
          'pages/forms.html':             ['src/jade/forms.jade']
          'pages/icons.html':             ['src/jade/icons.jade']
          'pages/responsive-text.html':   ['src/jade/responsive-text.jade']
          'pages/animations.html':        ['src/jade/animations.jade']
        options:
          pretty: true

    compass:
      build:
        options:
          config: 'config.rb'
          trace: true

    autoprefixer:
      build:
        options:
          browsers: ['last 2 versions']
        files:
          'css/groundwork.css': ['css/groundwork.css']

    coffee:
      individual:
        expand: true
        cwd: 'src/coffee'
        src: ['components/*.coffee', 'plugins/*.coffee']
        dest: 'js'
        ext: '.js'
      concatenated:
        options:
          join: true
        files:
          "js/groundwork.all.js": ["src/coffee/components/*.coffee", "src/coffee/plugins/*.coffee"]

    uglify:
      minify:
        files:
          'js/groundwork.all.js': ['js/groundwork.all.js']

    cssmin:
      minify:
        expand: true
        cwd: 'css/'
        src: ['*.css', '!*.min.css']
        dest: 'css/'
        ext: '.css'

  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-jade'
  grunt.loadNpmTasks 'grunt-contrib-compass'
  grunt.loadNpmTasks 'grunt-contrib-cssmin'
  grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.loadNpmTasks 'grunt-autoprefixer'

  grunt.registerTask 'default',           ['build']
  grunt.registerTask 'build',             ['jade', 'compass', 'autoprefixer', 'coffee', 'cssmin', 'uglify']
