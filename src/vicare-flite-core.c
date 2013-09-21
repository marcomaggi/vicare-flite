/*
  Part of: Vicare/Flite
  Contents: Flite for Vicare
  Date: Sat Sep 21, 2013

  Abstract

	Core functions.

  Copyright (C) 2013 Marco Maggi <marco.maggi-ipsu@poste.it>

  This program is  free software: you can redistribute  it and/or modify
  it under the  terms of the GNU General Public  License as published by
  the Free Software Foundation, either  version 3 of the License, or (at
  your option) any later version.

  This program  is distributed in the  hope that it will  be useful, but
  WITHOUT   ANY  WARRANTY;   without  even   the  implied   warranty  of
  MERCHANTABILITY  or FITNESS  FOR A  PARTICULAR PURPOSE.   See  the GNU
  General Public License for more details.

  You  should have received  a copy  of the  GNU General  Public License
  along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/


/** --------------------------------------------------------------------
 ** Headers.
 ** ----------------------------------------------------------------- */

#include "vicare-flite-internals.h"


/** --------------------------------------------------------------------
 ** Flite C wrappers.
 ** ----------------------------------------------------------------- */

ikptr
ikrt_flite_init (ikpcb * pcb)
{
#ifdef HAVE_FLITE_INIT
  /* rv = flite_init(); */
  return IK_VOID;
#else
  feature_failure(__func__);
#endif
}
ikptr
ikrt_flite_text_to_wave (ikpcb * pcb)
{
#ifdef HAVE_FLITE_TEXT_TO_WAVE
  /* rv = flite_text_to_wave(); */
  return IK_VOID;
#else
  feature_failure(__func__);
#endif
}
ikptr
ikrt_flite_file_to_speech (ikpcb * pcb)
{
#ifdef HAVE_FLITE_FILE_TO_SPEECH
  /* rv = flite_file_to_speech(); */
  return IK_VOID;
#else
  feature_failure(__func__);
#endif
}
ikptr
ikrt_flite_text_to_speech (ikpcb * pcb)
{
#ifdef HAVE_FLITE_TEXT_TO_SPEECH
  /* rv = flite_text_to_speech(); */
  return IK_VOID;
#else
  feature_failure(__func__);
#endif
}
ikptr
ikrt_flite_synth_text (ikpcb * pcb)
{
#ifdef HAVE_FLITE_SYNTH_TEXT
  /* rv = flite_synth_text(); */
  return IK_VOID;
#else
  feature_failure(__func__);
#endif
}
ikptr
ikrt_flite_synth_phones (ikpcb * pcb)
{
#ifdef HAVE_FLITE_SYNTH_PHONES
  /* rv = flite_synth_phones(); */
  return IK_VOID;
#else
  feature_failure(__func__);
#endif
}
ikptr
ikrt_flite_voice_select (ikpcb * pcb)
{
#ifdef HAVE_FLITE_VOICE_SELECT
  /* rv = flite_voice_select(); */
  return IK_VOID;
#else
  feature_failure(__func__);
#endif
}
ikptr
ikrt_flite_voice_add_lex_addenda (ikpcb * pcb)
{
#ifdef HAVE_FLITE_VOICE_ADD_LEX_ADDENDA
  /* rv = flite_voice_add_lex_addenda(); */
  return IK_VOID;
#else
  feature_failure(__func__);
#endif
}


/** --------------------------------------------------------------------
 ** Still to be implemented.
 ** ----------------------------------------------------------------- */

#if 0
ikptr
ikrt_flite-doit (ikpcb * pcb)
{
#ifdef HAVE_FLITE_DOIT
  return IK_VOID;
#else
  feature_failure(__func__);
#endif
}
#endif


/* end of file */
