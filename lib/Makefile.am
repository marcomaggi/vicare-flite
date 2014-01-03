## Process this file with automake to produce Makefile.in

EXTRA_DIST	= \
	vicare/speech-tools/flite/constants.sls.in

# These files are hand-written.
nobase_dist_libvicare_DATA = \
	vicare/speech-tools/flite.sls			\
	vicare/speech-tools/flite/unsafe-capi.sls	\
	vicare/speech-tools/flite/cond-expand.sls

# These files are created at configuration or make time.
nobase_nodist_libvicare2_DATA = \
	vicare/speech-tools/flite/constants.sls		\
	vicare/speech-tools/flite/features.sls

if WANT_NAUSICAA
nobase_dist_libvicare_DATA	+= nausicaa/speech-tools/flite.vicare.sls
endif

VICARE_LIB_INFIX	= speech-tools/flite

include $(top_srcdir)/meta/makefiles/lib.am

### end of file
