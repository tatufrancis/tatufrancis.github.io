module.exports = (grunt) ->

  grunt.initConfig
    pkg: grunt.file.readJSON("package.json")

    watch:
      styles:
        files: '**/*.scss'
        tasks: ['compass', 'autoprefixer', 'cssmin']
        options:
          livereload: true
      scripts:
        files: '**/*.coffee'
        tasks: ['coffee', 'uglify']
        options:
          livereload: true

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
        src: ['**/*.coffee', '!groundwork.all.coffee']
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
  grunt.loadNpmTasks 'grunt-contrib-compass'
  grunt.loadNpmTasks 'grunt-autoprefixer'
  grunt.loadNpmTasks 'grunt-contrib-cssmin'
  grunt.loadNpmTasks 'grunt-contrib-uglify'

  grunt.registerTask 'default',           ['build']
  grunt.registerTask 'build',             ['styles', 'scripts']
  grunt.registerTask 'styles',            ['compass', 'autoprefixer', 'cssmin']
  grunt.registerTask 'scripts',           ['coffee', 'uglify']

