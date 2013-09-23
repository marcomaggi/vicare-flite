;;; -*- coding: utf-8-unix -*-
;;;
;;;Part of: Vicare/Flite
;;;Contents: demo for documentation
;;;Date: Tue Jan 24, 2012
;;;
;;;Abstract
;;;
;;;
;;;
;;;Copyright (C) 2013 Marco Maggi <marco.maggi-ipsu@poste.it>
;;;
;;;This program is free software:  you can redistribute it and/or modify
;;;it under the terms of the  GNU General Public License as published by
;;;the Free Software Foundation, either version 3 of the License, or (at
;;;your option) any later version.
;;;
;;;This program is  distributed in the hope that it  will be useful, but
;;;WITHOUT  ANY   WARRANTY;  without   even  the  implied   warranty  of
;;;MERCHANTABILITY  or FITNESS FOR  A PARTICULAR  PURPOSE.  See  the GNU
;;;General Public License for more details.
;;;
;;;You should  have received  a copy of  the GNU General  Public License
;;;along with this program.  If not, see <http://www.gnu.org/licenses/>.
;;;


#!r6rs
(import (vicare)
  (prefix (vicare speech-tools flite) flite.)
  (prefix (vicare speech-tools flite constants) flite.))

(flite.flite-init)


;;;; helpers

(define-inline (%pretty-print ?thing)
  (pretty-print ?thing (current-error-port)))


;;;; version functions

(let ()

  (%pretty-print (list (flite.vicare-flite-version-interface-current)
		       (flite.vicare-flite-version-interface-revision)
		       (flite.vicare-flite-version-interface-age)
		       (flite.vicare-flite-version)))

  #t)


;;;; text to speech

(when #t
  (let ()

    (define voice
      (flite.flite-voice-select))
    (flite.flite-text-to-speech "text to speech play" voice "play")

    (void)))


;;;; done


;;; end of file
