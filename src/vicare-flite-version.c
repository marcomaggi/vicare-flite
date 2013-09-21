/*
  Part of: Vicare/Flite
  Contents: Flite for Vicare
  Date: Sat Jan 21, 2012

  Abstract

	Version functions.

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
 ** Version functions.
 ** ----------------------------------------------------------------- */

ikptr
ikrt_flite_version_interface_current (void)
{
  return IK_FIX(vicare_flite_VERSION_INTERFACE_CURRENT);
}
ikptr
ikrt_flite_version_interface_revision (void)
{
  return IK_FIX(vicare_flite_VERSION_INTERFACE_REVISION);
}
ikptr
ikrt_flite_version_interface_age (void)
{
  return IK_FIX(vicare_flite_VERSION_INTERFACE_AGE);
}
ikptr
ikrt_flite_version (ikpcb * pcb)
{
  return ika_bytevector_from_cstring(pcb, vicare_flite_VERSION_INTERFACE_STRING);
}

/* end of file */
