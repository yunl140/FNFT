/*
 * This file is part of FNFT.  
 *                                                                  
 * FNFT is free software; you can redistribute it and/or
 * modify it under the terms of the version 2 of the GNU General
 * Public License as published by the Free Software Foundation.
 *
 * FNFT is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *                                                                      
 * You should have received a copy of the GNU General Public License
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 *
 * Contributors:
 * Sander Wahls (TU Delft) 2018.
 */

#define FNFT_ENABLE_SHORT_NAMES

#include <stdio.h>
#include "fnft__errwarn.h"
#include "fnft__nse_fscatter.h"
#include "fnft__nse_finvscatter.h"
#include "fnft__misc.h"

static INT nse_finvscatter_test(INT kappa)
{
    INT ret_code = SUCCESS;

    const UINT D = 32;
    COMPLEX q[D], q_exact[D];
    REAL eps_t = 0.12;
    UINT deg, i;

    nse_discretization_t discretization =
        fnft_nse_discretization_2SPLIT2_MODAL;
    const UINT len = nse_fscatter_numel(D, discretization);
    COMPLEX result[len];

    for (i=0; i<D; i++) {
        q_exact[i] = ((REAL)(i+1)/(D+1))*CEXP(I*(REAL)i/D);
        q[i] = 0.0;
    }

    ret_code = nse_fscatter(D, q_exact, eps_t, kappa, result, &deg, NULL,
        discretization);
    CHECK_RETCODE(ret_code, leave_fun);

    ret_code = nse_finvscatter(deg, result, q, eps_t, kappa,
        discretization);
    CHECK_RETCODE(ret_code, leave_fun);

    REAL err = misc_rel_err(D, q, q_exact);
    if (!(err < 100*FNFT_EPSILON)) {
        ret_code = E_TEST_FAILED;
        goto leave_fun;
    }

leave_fun:
    return ret_code;
}

int main()
{
    if (nse_finvscatter_test(+1) != SUCCESS)
        return EXIT_FAILURE;

    if (nse_finvscatter_test(-1) != SUCCESS)
        return EXIT_FAILURE;

    return EXIT_SUCCESS;
}

