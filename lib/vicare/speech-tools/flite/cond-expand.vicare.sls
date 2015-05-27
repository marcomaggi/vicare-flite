;;; -*- coding: utf-8-unix -*-
;;;
;;;Part of: Vicare/Flite
;;;Contents: cond-expand clauses
;;;Date: Sat Sep 21, 2013
;;;
;;;Abstract
;;;
;;;
;;;
;;;Copyright (C) 2013 Marco Maggi <marco.maggi-ipsu@poste.it>
;;;
;;;This  program  is free  software:  you  can redistribute  it
;;;and/or modify it  under the terms of the  GNU General Public
;;;License as published by the Free Software Foundation, either
;;;version  3 of  the License,  or (at  your option)  any later
;;;version.
;;;
;;;This  program is  distributed in  the hope  that it  will be
;;;useful, but  WITHOUT ANY WARRANTY; without  even the implied
;;;warranty  of  MERCHANTABILITY or  FITNESS  FOR A  PARTICULAR
;;;PURPOSE.   See  the  GNU  General Public  License  for  more
;;;details.
;;;
;;;You should  have received a  copy of the GNU  General Public
;;;License   along   with    this   program.    If   not,   see
;;;<http://www.gnu.org/licenses/>.
;;;



#!r6rs
(library (vicare speech-tools flite cond-expand)
  (export vicare-flite-features)
  (import (only (vicare language-extensions cond-expand helpers)
		define-cond-expand-identifiers-helper)
    (vicare speech-tools flite features)
    (for (vicare speech-tools flite)
	 (meta -1)))


(define-cond-expand-identifiers-helper vicare-flite-features
  ;; cond-expand clauses Flite
  (flite-init			HAVE_FLITE_INIT)
  (flite-text-to-wave		HAVE_FLITE_TEXT_TO_WAVE)
  (flite-file-to-speech		HAVE_FLITE_FILE_TO_SPEECH)
  (flite-text-to-speech		HAVE_FLITE_TEXT_TO_SPEECH)
  (flite-synth-text		HAVE_FLITE_SYNTH_TEXT)
  (flite-synth-phones		HAVE_FLITE_SYNTH_PHONES)
  (flite-voice-select		HAVE_FLITE_VOICE_SELECT)
  (flite-voice-add-lex-addenda	HAVE_FLITE_VOICE_ADD_LEX_ADDENDA)
  (flite-utterance-finalise	HAVE_DELETE_UTTERANCE)
  (flite-process-output		HAVE_FLITE_PROCESS_OUTPUT)
  )


;;;; done

)

;;; end of file
