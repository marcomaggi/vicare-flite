/*
  Part of: Vicare/Flite
  Contents: print platform features library
  Date: Sat Sep 21, 2013

  Abstract



  Copyright (C) 2013 Marco Maggi <marco.maggi-ipsu@poste.it>

  This program is  free software: you can redistribute  it and/or modify
  it under the  terms of the GNU General Public  License as published by
  the Free Software Foundation, either version  3 of the License, or (at
  your option) any later version.

  This program  is distributed in the  hope that it will  be useful, but
  WITHOUT   ANY  WARRANTY;   without  even   the  implied   warranty  of
  MERCHANTABILITY  or FITNESS  FOR A  PARTICULAR PURPOSE.   See the  GNU
  General Public License for more details.

  You should  have received  a copy  of the  GNU General  Public License
  along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/


#ifdef HAVE_CONFIG_H
#  include <config.h>
#endif
#include <stdio.h>
#include <stdlib.h>


int
main (int argc, const char *const argv[])
{
  printf(";;; -*- coding: utf-8-unix -*-\n\
;;;\n\
;;;Part of: Vicare/Flite\n\
;;;Contents: static platform inspection\n\
;;;Date: Tue Jul 24, 2012\n\
;;;\n\
;;;Abstract\n\
;;;\n\
;;;\n\
;;;\n\
;;;Copyright (C) 2013 Marco Maggi <marco.maggi-ipsu@poste.it>\n\
;;;\n\
;;;This program is free software:  you can redistribute it and/or modify\n\
;;;it under the terms of the  GNU General Public License as published by\n\
;;;the Free Software Foundation, either version 3 of the License, or (at\n\
;;;your option) any later version.\n\
;;;\n\
;;;This program is  distributed in the hope that it  will be useful, but\n\
;;;WITHOUT  ANY   WARRANTY;  without   even  the  implied   warranty  of\n\
;;;MERCHANTABILITY or  FITNESS FOR  A PARTICULAR  PURPOSE.  See  the GNU\n\
;;;General Public License for more details.\n\
;;;\n\
;;;You should  have received a  copy of  the GNU General  Public License\n\
;;;along with this program.  If not, see <http://www.gnu.org/licenses/>.\n\
;;;\n\
\n\
\n\
#!r6rs\n\
(library (vicare speech-tools flite features)\n\
  (export\n\
    ;; Flite features\n\
    HAVE_FLITE_INIT\n\
    HAVE_FLITE_TEXT_TO_WAVE\n\
    HAVE_FLITE_FILE_TO_SPEECH\n\
    HAVE_FLITE_TEXT_TO_SPEECH\n\
    HAVE_FLITE_SYNTH_TEXT\n\
    HAVE_FLITE_SYNTH_PHONES\n\
    HAVE_FLITE_VOICE_SELECT\n\
    HAVE_FLITE_VOICE_ADD_LEX_ADDENDA\n\
    )\n\
  (import (rnrs))\n\
\n\
;;;; helpers\n\
\n\
(define-syntax define-inline-constant\n\
  (syntax-rules ()\n\
    ((_ ?name ?value)\n\
     (define-syntax ?name (identifier-syntax ?value)))))\n\
\n\
\n\
;;;; code\n\n");


/** --------------------------------------------------------------------
 ** Flite features.
 ** ----------------------------------------------------------------- */

printf("(define-inline-constant HAVE_FLITE_INIT %s)\n",
#ifdef HAVE_FLITE_INIT
  "#t"
#else
  "#f"
#endif
  );

printf("(define-inline-constant HAVE_FLITE_TEXT_TO_WAVE %s)\n",
#ifdef HAVE_FLITE_TEXT_TO_WAVE
  "#t"
#else
  "#f"
#endif
  );

printf("(define-inline-constant HAVE_FLITE_FILE_TO_SPEECH %s)\n",
#ifdef HAVE_FLITE_FILE_TO_SPEECH
  "#t"
#else
  "#f"
#endif
  );

printf("(define-inline-constant HAVE_FLITE_TEXT_TO_SPEECH %s)\n",
#ifdef HAVE_FLITE_TEXT_TO_SPEECH
  "#t"
#else
  "#f"
#endif
  );

printf("(define-inline-constant HAVE_FLITE_SYNTH_TEXT %s)\n",
#ifdef HAVE_FLITE_SYNTH_TEXT
  "#t"
#else
  "#f"
#endif
  );

printf("(define-inline-constant HAVE_FLITE_SYNTH_PHONES %s)\n",
#ifdef HAVE_FLITE_SYNTH_PHONES
  "#t"
#else
  "#f"
#endif
  );

printf("(define-inline-constant HAVE_FLITE_VOICE_SELECT %s)\n",
#ifdef HAVE_FLITE_VOICE_SELECT
  "#t"
#else
  "#f"
#endif
  );

printf("(define-inline-constant HAVE_FLITE_VOICE_ADD_LEX_ADDENDA %s)\n",
#ifdef HAVE_FLITE_VOICE_ADD_LEX_ADDENDA
  "#t"
#else
  "#f"
#endif
  );


  printf("\n\
;;;; done\n\
\n\
)\n\
\n\
;;; end of file\n");
  exit(EXIT_SUCCESS);
}

/* end of file */
