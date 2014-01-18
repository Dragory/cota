"use strict";

module.exports = function (grunt) {
    grunt.loadNpmTasks("grunt-contrib-coffee");
    grunt.loadNpmTasks("grunt-contrib-concat");
    grunt.loadNpmTasks("grunt-contrib-uglify");
    grunt.loadNpmTasks("grunt-contrib-watch");
    grunt.loadNpmTasks("grunt-contrib-copy");
    grunt.loadNpmTasks("grunt-contrib-compass");
    grunt.loadNpmTasks("grunt-contrib-clean");

    var gruntConfig = {
        coffee: {
            dist: {
                expand: true,
                flatten: false,
                cwd: 'assets/coffee',
                src: ['**/*.coffee'],
                dest: 'assets/_compiled/js/compiled/',
                ext: '.js'
            }
        },

        clean: {
            dist: ['assets/_compiled', 'public/css', 'public/js']
        },

        concat: {
            dist: {
                files: [
                    {
                        src: [
                            'assets/bower/jquery/jquery.min.js',
                            'assets/bower/angular/angular.js',
                            'assets/bower/angular-route/angular-route.js',
                            'assets/js/ext/**/*.js'
                        ],
                        dest: 'assets/_compiled/js/final/external.js'
                    },
                    {
                        src: [
                            'assets/_compiled/js/compiled/helpers.js',

                            'assets/_compiled/js/compiled/init.js',

                            'assets/_compiled/js/compiled/upgrades/**/*.js',
                            'assets/_compiled/js/compiled/actions/**/*.js',
                            'assets/_compiled/js/compiled/items/**/*.js',

                            'assets/_compiled/js/compiled/services/**/*.js',
                            'assets/_compiled/js/compiled/controllers/**/*.js',

                            'assets/_compiled/js/compiled/routes.js',
                            'assets/_compiled/js/compiled/app.js'
                        ],
                        dest: 'assets/_compiled/js/final/cota.js'
                    }
                ]
            }
        },

        uglify: {
            options: {
                preserveComments: "some"
            },
            dist: {
                files: {
                    "assets/_compiled/js/final/external.min.js": ["public/js/external.js"],
                    "assets/_compiled/js/final/cota.min.js": ["public/js/cota.js"]
                }
            }
        },

        copy: {
            devMinScripts: {
                files: [
                    {
                        src: 'assets/_compiled/js/final/external.js',
                        dest: 'public/js/external.min.js'
                    },
                    {
                        src: 'assets/_compiled/js/final/cota.js',
                        dest: 'public/js/cota.min.js'
                    }
                ]
            }
        },

        watch: {
            scripts: {
                files: ['assets/coffee/**/*.coffee'],
                tasks: ['scripts-dev'],
                options: {
                    "spawn": false
                }
            },

            styles: {
                files: ['assets/scss/**/*.scss'],
                tasks: ['styles-dev'],
                options: {
                    "spawn": false
                }
            }
        },

        compass: {
            dev: {
                options: {
                    sassDir: 'assets/scss',
                    cssDir: 'public/css',
                    environment: 'production'
                }
            },

            dist: {
                options: {
                    sassDir: 'assets/scss',
                    cssDir: 'public/css',
                    environment: 'production'
                }
            }
        }
    };

    gruntConfig.uglify['check'] = {
        options: {
            report: 'gzip'
        },
        files: gruntConfig.uglify.dist.files
    };

    grunt.initConfig(gruntConfig);

    grunt.registerTask("default", ["dev"]);

    // "Complete" tasks
    grunt.registerTask("dev", ["scripts-dev", "styles-dev"]);
    grunt.registerTask("prod", ["scripts-prod", "styles-prod"]);

    // Dev tasks
    grunt.registerTask("scripts-dev", ["clean:dist", "coffee", "concat", "copy:devMinScripts"]);
    grunt.registerTask("styles-dev", ["compass:dev"]);

    // Prod tasks
    grunt.registerTask("scripts-prod", ["clean:dist", "coffee", "concat", "uglify:dist"]);
    grunt.registerTask("styles-prod", ["compass:dist"]);
};
