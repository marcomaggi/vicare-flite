dnl @configure_input@
dnl

AC_PREREQ([2.68])
AC_INIT([Vicare/Flite],[0.1d0],[marco.maggi-ipsu@poste.it],
  [vicare-flite],[http://marcomaggi.github.com/vicare.html])
AC_CONFIG_SRCDIR([src])
AC_CONFIG_MACRO_DIR([autotools])
AC_CONFIG_AUX_DIR([autotools])
AC_CANONICAL_BUILD
AC_CANONICAL_HOST
AC_CANONICAL_TARGET
AM_INIT_AUTOMAKE([-Wall foreign dist-xz no-dist-gzip])
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

VICARE_OPTION_DEBUGGING_MODE
VICARE_OPTION_NAUSICAA([no])
AM_CONDITIONAL([WANT_NAUSICAA],[test x$vicare_with_nausicaa = xyes])

AM_CONDITIONAL([WANT_VICARE_DEBUG],[test x$VICARE_DEBUG = xyes])
AM_COND_IF([WANT_VICARE_DEBUG],[AS_VAR_SET(VFLAGS,"$VFLAGS -g")])

AC_LANG([C])
AC_DEFINE([_GNU_SOURCE],[1],[enable everything GNU])

#page
#### flite configuration

AC_CHECK_HEADERS([flite/flite.h],,
  [AC_MSG_FAILURE([missing flite.h header],[2])])

AC_CHECK_LIB([linux-vdso],[main],,
  [AC_MSG_FAILURE([missing Linux VDSO library],[2])])

AC_CHECK_LIB([flite],[flite_init],,
  [AC_MSG_FAILURE([missing Flite library],[2])])

AC_CHECK_LIB([flite_cmulex],[main],,
  [AC_MSG_FAILURE([missing Flite library],[2])])

AC_CHECK_LIB([flite_usenglish],[main],,
  [AC_MSG_FAILURE([missing Flite library],[2])])

AC_CHECK_LIB([flite_cmu_us_kal],[main],,
  [AC_MSG_FAILURE([missing Flite library],[2])])

AC_CHECK_LIB([flite_cmu_us_kal16],[main],,
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
#ifdef HAVE_FLITE_H
#  include <flite/flite.h>
#endif
])

dnl Stuff
dnl VICARE_CONSTANT_TESTS([XML_TRUE XML_FALSE])

#page
#### C language functions from the header file "libesmtp.h"

dnl Flite functions checking
AC_CHECK_FUNCS([flite_init flite_text_to_wave flite_file_to_speech flite_text_to_speech flite_synth_text flite_synth_phones flite_voice_select flite_voice_add_lex_addenda])

#page
#### finish

VICARE_OUTPUT
AC_CONFIG_HEADERS([config.h])
AC_CONFIG_FILES([Makefile]
        [src/Makefile]
        [doc/Makefile]
        [tests/Makefile]
        [lib/Makefile]
        [lib/vicare/speech-tools/flite/constants.sls]
        [meta/slackware/doinst.sh])
AC_OUTPUT

### end of file
# Local Variables:
# mode: autoconf
# page-delimiter: "^#page"
# End:
