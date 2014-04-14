module.exports = function(grunt) {
	var fs = require('fs');
	require('shelljs/global');

	grunt.initConfig({
		pkg: grunt.file.readJSON('package.json'),

		clean: [
			'app/*.html',
			'app/scripts/*',
			'app/App_Resources/*',
			'app/data/*',
			'app/styles/*'
		],

		jasmine: {
			src: ['app/scripts/app.js'],
			options: {
				keepRunner: false,
				specs: [
					"tests/generated/app.spec.js"
				],
				vendor: [
					"app/kendo/js/jquery.min.js",
					"app/kendo/js/kendo.mobile.min.js"
				]
			}
		},

		coffee: {
			compile: {
				files: {
					'tests/generated/app.spec.js': 'tests/**/*.spec.coffee',
					'app/scripts/app.js': 'src/scripts/**/*.coffee'
				}
			}
		},
		
		less: {
			developent: {
				files: {
				  'app/styles/app.css': 'src/styles/app.less'
				}
			}
		},

		copy: {
			main: {
				files: [
					{ expand: true, cwd: 'src/', src: ['*.html'], dest: 'app/'},
					{ expand: true, cwd: 'src/App_Resources/', src: ['*'], dest: 'app/App_Resources/'},
					{ expand: true, cwd: 'src/data/', src: ['*'], dest: 'app/data/'},
					{ expand: true, cwd: 'src/styles/', src: ['**/*.!(less)'], dest: 'app/styles/'},
					{ expand: true, cwd: 'src/scripts/', src: ['**/*.!(coffee)'], dest: 'app/scripts/'}
				]
			}
		},
		
		jade: {
			compile: {
				options: {
					pretty: true,
					data: {
						debug: false
					}
				},
				files: {
					"app/index.html": ["src/*.jade"]
				}
			}
		}
	});

	require('load-grunt-tasks')(grunt);
	
	grunt.registerTask('appbuilder-create', function () {
		if(!fs.existsSync('app')) {
			if (exec('appbuilder create app').code !== 0) {
			  grunt.log.error("AppBuilder failed to create a new app.");
			  return false;
			}
		}
		return true;
	});

	grunt.registerTask('default', ['appbuilder-create', 'clean', 'coffee', 'less', 'jade', 'copy', 'jasmine']);
};