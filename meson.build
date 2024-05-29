project('hello-world', 'c',
  version : '0.1',
  default_options : ['warning_level=3', 'werror=true', 'optimization=3', 'buildtype=release'])

INC = include_directories('inc')
SRCS = files('src/hello-world.c', 'src/main.c')
DIST_BASE = 'bin/'
DIST = DIST_BASE + 'release'
FLAGS = ['-fstack-protector-all', '-D_FORTIFY_SOURCE=2', '-znoexecstack']

if get_option('buildtype') == 'debug'
  DIST = DIST_BASE + 'debug'
endif

dynamic_linked = executable('hello-world',
           SRCS,
           c_args: FLAGS,
           link_args: FLAGS,
           include_directories: INC,
           install_dir: DIST + '/dynamic/',
           install: true,
           pie: true)

static_linked = executable('hello-world-static',
        SRCS,
        c_args: FLAGS + '-static-pie',
        link_args: FLAGS + '-static-pie',
        include_directories: INC,
        install_dir: DIST + '/static/',
        install: true,
        pie: true)

test('simple test 1', dynamic_linked, args: ['test'], verbose: false)
test('simple test 2', dynamic_linked, args: ['okay'], verbose: false)
test('simple test 3', dynamic_linked, args: ['name'], should_fail: true, verbose: false)
test('simple test 2', dynamic_linked, args: ['sam'], verbose: false)
