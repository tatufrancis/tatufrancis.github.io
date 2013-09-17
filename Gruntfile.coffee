module.exports = (grunt) ->

  grunt.initConfig
    pkg: grunt.file.readJSON("package.json")

    watch:
      jade:
        files: '**/*.jade'
        tasks: ['jade']
        options:
          livereload: true
      compass:
        files: '**/*.scss'
        tasks: ['compass', 'autoprefixer']
      coffee:
        files: '**/*.coffee'
        tasks: ['coffee']

    jade:
      build:
        files:
          'docs/home.html':                ['src/jade/home.jade']
          'docs/layout-a.html':            ['src/jade/layout-a.jade']
          'docs/layout-b.html':            ['src/jade/layout-b.jade']
          'docs/layout-c.html':            ['src/jade/layout-c.jade']
          'docs/grid.html':                ['src/jade/grid.jade']
          'docs/helpers.html':             ['src/jade/helpers.jade']
          'docs/typography.html':          ['src/jade/typography.jade']
          'docs/navigation.html':          ['src/jade/navigation.jade']
          'docs/buttons.html':             ['src/jade/buttons.jade']
          'docs/boxes.html':               ['src/jade/boxes.jade']
          'docs/messages.html':            ['src/jade/messages.jade']
          'docs/tables.html':              ['src/jade/tables.jade']
          'docs/tabs.html':                ['src/jade/tabs.jade']
          'docs/forms.html':               ['src/jade/forms.jade']
          'docs/icons.html':               ['src/jade/icons.jade']
          'docs/responsive-text.html':     ['src/jade/responsive-text.jade']
          'docs/placeholder-text.html':    ['src/jade/placeholder-text.jade']
          'docs/animations.html':          ['src/jade/animations.jade']
          'docs/breakpoints.html':         ['src/jade/breakpoints.jade']
          'docs/media-queries.html':       ['src/jade/media-queries.jade']
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
