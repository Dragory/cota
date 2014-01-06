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
                cwd: 'coffee',
                src: ['**/*.coffee'],
                dest: 'js/compiled/',
                ext: '.js'
            }
        },

        clean: {
            dist: ['js/compiled', 'js/final']
        },

        concat: {
            dist: {
                files: [
                    {
                        src: [
                            'components/jquery/jquery.min.js',
                            'components/angular/angular.js',
                            'js/ext/**/*.js'
                        ],
                        dest: 'js/final/external.js'
                    },
                    {
                        src: ['js/compiled/**/*.js'],
                        dest: 'js/final/cota.js'
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
                    "js/final/external.min.js": ["js/final/external.js"],
                    "js/final/cota.min.js": ["js/final/cota.js"]
                }
            }
        },

        copy: {
            devMinScripts: {
                files: [
                    {
                        src: 'js/final/external.js',
                        dest: 'js/final/external.min.js'
                    },
                    {
                        src: 'js/final/cota.js',
                        dest: 'js/final/cota.min.js'
                    }
                ]
            }
        },

        watch: {
            scripts: {
                files: ['coffee/**/*.coffee'],
                tasks: ['scripts-dev'],
                options: {
                    "spawn": false
                }
            },

            styles: {
                files: ['scss/**/*.scss'],
                tasks: ['styles-dev'],
                options: {
                    "spawn": false
                }
            }
        },

        compass: {
            dev: {
                options: {
                    sassDir: 'scss',
                    cssDir: 'css',
                    environment: 'production'
                }
            },
            
            dist: {
                options: {
                    sassDir: 'scss',
                    cssDir: 'css',
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
