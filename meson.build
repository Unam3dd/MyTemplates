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

if (cc.get_id() == 'linux' or cc.get_id() == 'gcc')
  FLAGS = ['-fstack-protector-all', '-D_FORTIFY_SOURCE=2']
elif (host_machine.system() == 'windows' and cc.get_id() == 'clang-cl' or cc.get_id() == 'cl')
  FLAGS = []
endif

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

FILES = files('src/mylib.c', 'src/hello-world.c')
MAIN =  files('src/main.c')
SRCS = FILES + MAIN

######################################
#
#             UNIT TESTS
#
######################################

TESTS = files('tests/mylib.c')

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
  'BuildType': get_option('buildtype'),
  'Libdir': get_option('libdir'),
  'Datadir': get_option('datadir'),
  }, section: 'Project Overview')

######################################
#
#             DEPENDENCIES
#
######################################

criterion = dependency('criterion', required: false)

if not criterion.found() and get_option('build-tests')
  criterion = dependency('criterion', allow_fallback: true)
endif

######################################
#
#           Executable
#
######################################

if (host_machine.system() == 'linux')

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
else
  static_linked = executable('hello-world',
        SRCS,
        c_args: FLAGS,
        link_args: FLAGS,
        include_directories: INC,
        install_dir: DIST,
        install: true) 
endif

######################################
#
#             TESTS
#
######################################

if get_option('build-tests') and host_machine.system() == 'linux'
  DBG_FLAGS = ['-g3', '-Oz' ,'-fPIC']
  foreach f: TESTS
    test_name = 'test_' + f.full_path().split('/')[-1].split('.c')[0]
    test_exec = executable(test_name,
      [f, FILES], c_args: DBG_FLAGS,
      dependencies: criterion,
      include_directories: INC,
      install: false)
    test(test_name, test_exec, args: ['--verbose'], verbose: true)
  endforeach
endif

if host_machine.system() == 'linux'
  test('simple test 1', dynamic_linked, args: ['test'], verbose: false)
  test('simple test 2', dynamic_linked, args: ['okay'], verbose: false)
  test('simple test 3', dynamic_linked, args: ['name'], should_fail: true, verbose: false)
  test('simple test 2', dynamic_linked, args: ['sam'], verbose: false)
endif

test('simple test 1', static_linked, args: ['test'], verbose: false)
test('simple test 2', static_linked, args: ['okay'], verbose: false)
test('simple test 3', static_linked, args: ['name'], should_fail: true, verbose: false)
test('simple test 2', static_linked, args: ['sam'], verbose: false)
