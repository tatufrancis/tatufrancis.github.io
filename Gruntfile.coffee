module.exports = (grunt) ->

  grunt.initConfig
    pkg: grunt.file.readJSON("package.json")

    watch:
      config:
        files: ['package.json', 'Gruntfile.coffee']
      docs:
        files: 'src/**/*.jade'
        tasks: ['docs']
        options:
          livereload: true
      styles:
        files: ['src/**/*.scss', 'config.rb']
        tasks: ['styles']
        options:
          livereload: true
      scripts:
        files: ['src/**/*.coffee', '!Gruntfile.coffee', '!groundwork.all.coffee']
        tasks: ['scripts']
        options:
          livereload: true
      # tests:
      #   files: ['src/scss/**/*.scss', 'tests/src/**/*', 'tests.rb']
      #   tasks: ['tests']
      #   options:
      #     livereload: true

    jade:
      build:
        options:
          pretty: true
        files: [
          expand: true
          cwd: 'src/jade'
          src: ['**/*.jade', '!template.jade']
          dest: 'docs'
          ext: '.html'
        ]
      # tests:
      #   options:
      #     pretty: true
      #   files: [
      #     expand: true
      #     cwd: 'tests/src/jade'
      #     src: ['**/*.jade', '!template.jade']
      #     dest: 'tests'
      #     ext: '.html'
      #   ]

    compass:
      build:
        options:
          config: 'config.rb'
          trace: true
      # tests:
      #   options:
      #     config: 'tests.rb'
      #     trace: true

    autoprefixer:
      build:
        options:
          browsers: ['last 2 versions']
        files: [
          expand: true
          cwd: 'css'
          src: ['**/groundwork*.css']
          dest: 'css'
          ext: '.css'
        ]
      # tests:
      #   options:
      #     browsers: ['last 2 versions']
      #   files: [
      #     expand: true
      #     cwd: 'tests/css'
      #     src: ['**/*.css']
      #     dest: 'tests/css'
      #     ext: '.css'
      #   ]

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
      build:
        files:
          'js/groundwork.all.min.js': ['js/groundwork.all.js']

    cssmin:
      build:
        expand: true
        cwd: 'css/'
        src: ['**/*.css', '!.min.css']
        dest: 'css/'
        ext: '.css'

  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-jade'
  grunt.loadNpmTasks 'grunt-contrib-compass'
  grunt.loadNpmTasks 'grunt-autoprefixer'
  grunt.loadNpmTasks 'grunt-contrib-cssmin'
  grunt.loadNpmTasks 'grunt-contrib-uglify'

  grunt.registerTask 'default',           ['build']
  grunt.registerTask 'build',             ['styles', 'scripts']
  grunt.registerTask 'styles',            ['compass:build', 'autoprefixer:build']
  grunt.registerTask 'scripts',           ['coffee']
  grunt.registerTask 'tests',             ['compass:tests', 'autoprefixer:tests', 'jade:tests']
  grunt.registerTask 'docs',              ['jade:build']
  grunt.registerTask 'compress',          ['cssmin', 'uglify']
  grunt.registerTask 'package',           ['styles', 'scripts', 'docs', 'compress'] # 'tests', 
