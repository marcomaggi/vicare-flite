dnl @configure_input@
dnl

AC_PREREQ([2.68])
AC_INIT([Vicare/Flite],[0.4d1],[marco.maggi-ipsu@poste.it],
  [vicare-flite],[http://marcomaggi.github.com/vicare.html])
AC_CONFIG_SRCDIR([src])
AC_CONFIG_MACRO_DIR([meta/autotools])
AC_CONFIG_AUX_DIR([meta/autotools])
AC_CANONICAL_BUILD
AC_CANONICAL_HOST
AC_CANONICAL_TARGET
AM_INIT_AUTOMAKE([foreign subdir-objects dist-xz no-dist-gzip])
AM_MAINTAINER_MODE

AC_PROG_CC
AC_PROG_CC_C_O
AM_PROG_AR
AC_PROG_INSTALL
AC_PROG_LN_S
AC_PROG_MAKE_SET
AC_PROG_MKDIR_P
LT_PREREQ([2.4])
LT_INIT([shared disable-static])

VICARE_SCHEME
VICARE_CHECK_LIBRARY([VICARE],[(vicare (0 4 2017 1 (>= 10)))])
AS_IF([test "$vicare_cv_schemelib_VICARE" = no],
  [AC_MSG_ERROR([wrong Vicare version],1)])

dnl VICARE_CHECK_LIBRARY([VICARE_FFI],
dnl   [(vicare ffi (or (0 4 2015 5 (>= 27))
dnl                    (0 4 2015 (>= 6))
dnl                    (0 4 (>= 2016))))])
dnl AS_IF([test "$vicare_cv_schemelib_VICARE_FFI" = no],
dnl   [AC_MSG_ERROR([wrong Vicare FFI library version],1)])

# Command  line  options  for  the executable  "vicare".   The  variable
# AX_VFLAGS is  for options preselected by  the building infrastructure.
# The variable VFLAGS  is for user options selected on  the command line
# of "configure" and "make", for example:
#
#    $ make VFLAGS="-g --print-loaded-libraries"
#
AS_VAR_SET(AX_VFLAGS,["-O2 --verbose"])
AS_VAR_SET_IF(VFLAGS,,[AS_VAR_SET(VFLAGS)])

VICARE_OPTION_DEBUGGING_MODE

AM_CONDITIONAL([WANT_VICARE_DEBUG],[test x$VICARE_DEBUG = xyes])
AM_COND_IF([WANT_VICARE_DEBUG],[AS_VAR_SET(VFLAGS,"$VFLAGS -g")])

VICARE_ENABLE_OPTION([INSTALL_SOURCES],[sources-installation],[no],
  [whether to install source Scheme libraries],
  [enable installation of source Scheme libraries])
AM_CONDITIONAL([WANT_INSTALL_SOURCES],
  [test "x$vicare_enable_INSTALL_SOURCES" = xyes])

AC_LANG([C])
AC_DEFINE([_GNU_SOURCE],[1],[enable everything GNU])

VICARE_ENABLE_OPTION([TIME_TESTS],[time-tests],[no],
  [whether to enable timing of tests],
  [enable timing of tests])
AM_CONDITIONAL([WANT_TIME_TESTS],[test "x$vicare_enable_TIME_TESTS" = xyes])

AM_COND_IF([WANT_TIME_TESTS],
  [AC_PATH_PROG([TIME_PROGRAM],[time])])

#page
#### flite configuration

AC_CHECK_HEADERS([flite/flite.h],,
  [AC_MSG_FAILURE([missing flite.h header],[2])])
AC_CHECK_HEADERS([flite/flite_version.h],,
  [AC_MSG_FAILURE([missing flite_version.h header],[2])])

dnl Beware of the order of the libraries!!!

AC_CHECK_LIB([asound],[main],,
  [AC_MSG_FAILURE([missing ALSA library],[2])])

AC_CHECK_LIB([flite],[flite_init],,
  [AC_MSG_FAILURE([missing Flite library],[2])])

AC_CHECK_LIB([flite_cmulex],[main],,
  [AC_MSG_FAILURE([missing Flite library],[2])])

AC_CHECK_LIB([flite_usenglish],[main],,
  [AC_MSG_FAILURE([missing Flite library],[2])])

AC_CHECK_LIB([flite_cmu_us_kal],[main],,
  [AC_MSG_FAILURE([missing Flite library],[2])])

dnl This is not a voice.
dnl
dnl AC_CHECK_LIB([flite_cmu_time_awb],[main],,
dnl   [AC_MSG_FAILURE([missing Flite library],[2])])

AC_CHECK_LIB([flite_cmu_us_kal16],[main],,
  [AC_MSG_FAILURE([missing Flite library],[2])])

AC_CHECK_LIB([flite_cmu_us_awb],[main],,
  [AC_MSG_FAILURE([missing Flite library],[2])])

AC_CHECK_LIB([flite_cmu_us_rms],[main],,
  [AC_MSG_FAILURE([missing Flite library],[2])])

AC_CHECK_LIB([flite_cmu_us_slt],[main],,
  [AC_MSG_FAILURE([missing Flite library],[2])])

VICARE_EXTENSION_LIBRARY_VERSION([flite],[0],[0],[0])

#page
#### C language preprocessor symbols from the file "libesmtp.h"

m4_define([VICARE_INCLUDES],[
AC_INCLUDES_DEFAULT
#ifdef HAVE_VICARE_H
#  include <vicare.h>
#endif
#ifdef HAVE_FLITE_FLITE_H
#  include <flite/flite.h>
#endif
#ifdef HAVE_FLITE_FLITE_VERSION_H
#  include <flite/flite_version.h>
#endif
])

dnl Version constants
VICARE_STRING_CONSTANT_TESTS([FLITE_PROJECT_NAME FLITE_PROJECT_PREFIX FLITE_PROJECT_VERSION FLITE_PROJECT_DATE FLITE_PROJECT_STATE FLITE_PROJECT_SHLIB_VERSION])

#page
#### C language functions from the header file "libesmtp.h"

dnl Flite functions checking
AC_CHECK_FUNCS([flite_init flite_text_to_wave flite_file_to_speech flite_text_to_speech flite_synth_text flite_synth_phones flite_voice_select flite_voice_add_lex_addenda delete_utterance flite_process_output])

AC_CHECK_FUNCS([register_cmu_time_awb register_cmu_us_awb register_cmu_us_kal register_cmu_us_kal16 register_cmu_us_rms register_cmu_us_slt])

#page
#### finish

VICARE_OUTPUT
AC_CONFIG_HEADERS([config.h])
AC_CONFIG_FILES([Makefile]
        [lib/vicare/speech-tools/flite/constants.vicare.sls])
AC_OUTPUT

### end of file
# Local Variables:
# mode: autoconf
# page-delimiter: "^#page"
# End:
