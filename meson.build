project('hello-world', 'c',
  version : '0.1',
  default_options : ['warning_level=3', 'werror=true', 'optimization=3', 'buildtype=release'])

######################################
#
#     COMPILER & LINKER
#
######################################

cc = meson.get_compiler('c')
linker = cc.get_linker_id()

if (host_machine.system() == 'linux')
  ld = find_program('ld', required: false)
endif

FLAGS = ['-fstack-protector-all', '-D_FORTIFY_SOURCE=2']

######################################
#
#             INCLUDES
#
######################################

INC = include_directories('inc')

######################################
#
#             SOURCES
#
######################################

SRCS = files('src/hello-world.c', 'src/main.c')

######################################
#
#             OUTPUT
#
######################################

DIST_BASE = 'bin/'
DIST = DIST_BASE + 'release'

if get_option('buildtype') == 'debug'
  DIST = DIST_BASE + 'debug'
endif

######################################
#
#             Summary
#
######################################

summary({
  'CPU': build_machine.cpu(),
  'Endian': build_machine.endian(),
  'System': build_machine.system()
  }, section: 'Machine Information')

if (host_machine.system() == 'linux')
summary({
  'C Compiler': cc.get_id() + ' ' + cc.version(),
  'Dynamic linker path': ld,
  'Dynamic linker': ld.version(),
  }, section: 'Compiler and Linker Information')
else
summary({
  'C Compiler': cc.get_id() + ' ' + cc.version(),
  }, section: 'Compiler Information')
endif

summary({
  'Name': meson.project_name(),
  'Version': meson.project_version(),
  'Root': meson.source_root(),
  'Cross Platform': meson.is_cross_build(),
  'Prefix': get_option('prefix'),
  'Libdir': get_option('libdir'),
  'Datadir': get_option('datadir'),
  }, section: 'Project Overview')


######################################
#
#           Executable
#
######################################

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
        c_args: FLAGS,
        link_args: FLAGS,
        include_directories: INC,
        install_dir: DIST + '/static/',
        install: true,
        pie: true)

######################################
#
#             TESTS
#
######################################

test('simple test 1', dynamic_linked, args: ['test'], verbose: false)
test('simple test 2', dynamic_linked, args: ['okay'], verbose: false)
test('simple test 3', dynamic_linked, args: ['name'], should_fail: true, verbose: false)
test('simple test 2', dynamic_linked, args: ['sam'], verbose: false)

test('simple test 1', static_linked, args: ['test'], verbose: false)
test('simple test 2', static_linked, args: ['okay'], verbose: false)
test('simple test 3', static_linked, args: ['name'], should_fail: true, verbose: false)
test('simple test 2', static_linked, args: ['sam'], verbose: false)
