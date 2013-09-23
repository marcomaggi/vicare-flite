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
  (vicare arguments validation)
  (vicare checks))

(check-set-mode! 'report-failed)
(check-display "*** testing Vicare Flite bindings\n")

(flite-init)


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


(parametrise ((check-test-name		'voice-struct)
	      (struct-guardian-logger	#f))

  (define who 'test)

;;; --------------------------------------------------------------------

  (check	;this will be garbage collected
      (let ((voice (flite-voice-select "rms")))
	;;;(debug-print voice)
	(flite-voice? voice))
    => #t)

  (check
      (flite-voice?/alive (flite-voice-select "rms"))
    => #t)

  (check	;single finalisation
      (let ((voice (flite-voice-select "rms")))
  	(flite-voice-finalise voice))
    => #f)

  (check	;double finalisation
      (let ((voice (flite-voice-select "rms")))
  	(flite-voice-finalise voice)
  	(flite-voice-finalise voice))
    => #f)

  (check	;alive predicate after finalisation
      (let ((voice (flite-voice-select "rms")))
  	(flite-voice-finalise voice)
  	(flite-voice?/alive voice))
    => #f)

;;; --------------------------------------------------------------------
;;; destructor

  (check
      (with-result
       (let ((voice (flite-voice-select "rms")))
	 (set-flite-voice-custom-destructor! voice (lambda (voice)
						     (add-result 123)))
	 (flite-voice-finalise voice)))
    => '(#f (123)))

;;; --------------------------------------------------------------------
;;; hash

  (check-for-true
   (integer? (flite-voice-hash (flite-voice-select "rms"))))

  (check
      (let ((A (flite-voice-select))
	    (B (flite-voice-select))
	    (T (make-hashtable flite-voice-hash eq?)))
	(hashtable-set! T A 1)
	(hashtable-set! T B 2)
	(list (hashtable-ref T A #f)
	      (hashtable-ref T B #f)))
    => '(1 2))

;;; --------------------------------------------------------------------
;;; properties

  (check
      (let ((S (flite-voice-select "rms")))
	(flite-voice-property-list S))
    => '())

  (check
      (let ((S (flite-voice-select "rms")))
	(flite-voice-putprop S 'ciao 'salut)
	(flite-voice-getprop S 'ciao))
    => 'salut)

  (check
      (let ((S (flite-voice-select "rms")))
	(flite-voice-getprop S 'ciao))
    => #f)

  (check
      (let ((S (flite-voice-select "rms")))
	(flite-voice-putprop S 'ciao 'salut)
	(flite-voice-remprop S 'ciao)
	(flite-voice-getprop S 'ciao))
    => #f)

  (check
      (let ((S (flite-voice-select "rms")))
	(flite-voice-putprop S 'ciao 'salut)
	(flite-voice-putprop S 'hello 'ohayo)
	(list (flite-voice-getprop S 'ciao)
	      (flite-voice-getprop S 'hello)))
    => '(salut ohayo))

;;; --------------------------------------------------------------------
;;; arguments validation

  (check-for-true
   (let ((S (flite-voice-select "rms")))
     (with-arguments-validation (who)
	 ((flite-voice	S))
       #t)))

  (check-for-true
   (let ((S (flite-voice-select "rms")))
     (flite-voice-finalise S)
     (with-arguments-validation (who)
	 ((flite-voice	S))
       #t)))

  (check-for-true
   (let ((S (flite-voice-select "rms")))
     (with-arguments-validation (who)
	 ((flite-voice/alive	S))
       #t)))

;;;

  (check-for-procedure-argument-violation
   (let ((S 123))
     (with-arguments-validation (who)
	 ((flite-voice	S))
       #t))
   '(123))

  (check-for-procedure-argument-violation
   (let ((S 123))
     (with-arguments-validation (who)
	 ((flite-voice/alive	S))
       #t))
   '(123))

  (let ((S (flite-voice-select "rms")))
    (check-for-procedure-argument-violation
     (begin
       (flite-voice-finalise S)
       (with-arguments-validation (who)
	   ((flite-voice/alive	S))
	 #t))
     (list S)))

  (collect))


(parametrise ((check-test-name		'voice-ops))

;;; voice name

  (check
      (let ((voice (flite-voice-select)))
  	(flite-voice-name voice))
    => "rms")

  (check
      (let ((voice (flite-voice-select "slt")))
  	(flite-voice-name voice))
    => "slt")

  (check
      (let ((voice (flite-voice-select "kal")))
  	(flite-voice-name voice))
    => "kal")

  (check
      (let ((voice (flite-voice-select "kal16")))
  	(flite-voice-name voice))
    => "kal16")

  (check
      (let ((voice (flite-voice-select "awb")))
  	(flite-voice-name voice))
    => "awb")

;;; --------------------------------------------------------------------

  (check-for-true
   (let ((N (flite-available-voice-names)))
     (check-pretty-print (list 'available-voices N))
     (for-all string? N)))

  #t)


(parametrise ((check-test-name		'text-to-speech))

  (check-for-true
   (let ((voice (flite-voice-select "rms")))
     (flonum? (flite-text-to-speech "hello world" voice "play"))))

  (check-for-true
   (let ((voice (flite-voice-select "slt")))
     (flonum? (flite-text-to-speech "hello world" voice "play"))))

  (check-for-true
   (let ((voice (flite-voice-select "kal")))
     (flonum? (flite-text-to-speech "hello world" voice "play"))))

  #t)


;;;; done

(check-report)

;;; end of file
