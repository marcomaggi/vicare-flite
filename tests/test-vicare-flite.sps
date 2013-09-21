;;; -*- coding: utf-8-unix -*-
;;;
;;;Part of: Vicare/Flite
;;;Contents: tests for Flite bindings
;;;Date: Sat Sep 21, 2013
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
  (vicare speech-tools flite)
  (vicare speech-tools flite constants)
;;;  (prefix (vicare ffi) ffi.)
  (vicare checks))

(check-set-mode! 'report-failed)
(check-display "*** testing Vicare Flite bindings\n")


;;;; helpers



(parametrise ((check-test-name	'version))

  (check
      (fixnum? (vicare-flite-version-interface-current))
    => #t)

  (check
      (fixnum? (vicare-flite-version-interface-revision))
    => #t)

  (check
      (fixnum? (vicare-flite-version-interface-age))
    => #t)

  (check
      (string? (vicare-flite-version))
    => #t)

  #t)


;;;; done

(check-report)

;;; end of file