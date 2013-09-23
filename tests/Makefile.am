## Process this file with automake to produce Makefile.in

VICARE_FLITE_PLAIN_TESTS	= \
	test-vicare-flite.sps

VICARE_FLITE_NAU_TESTS		= \
	test-nausicaa-flite.sps

TESTS	= $(VICARE_FLITE_PLAIN_TESTS)
if WANT_NAUSICAA
TESTS	+= $(VICARE_FLITE_NAU_TESTS)
endif

EXTRA_DIST = \
	$(VICARE_FLITE_PLAIN_TESTS)		\
	$(VICARE_FLITE_NAU_TESTS)		\
	\
	demo-for-documentation.sps		\
	demo-for-nau-documentation.sps

include $(top_srcdir)/meta/makefiles/tests.am

### end of file
