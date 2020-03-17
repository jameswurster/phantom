!--------------------------------------------------------------------------!
! The Phantom Smoothed Particle Hydrodynamics code, by Daniel Price et al. !
! Copyright (c) 2007-2020 The Authors (see AUTHORS)                        !
! See LICENCE file for usage and distribution conditions                   !
! http://phantomsph.bitbucket.io/                                          !
!--------------------------------------------------------------------------!
!+
!  MODULE: mol_data
!
!  DESCRIPTION:
!  Written by S. Glover, AMNH, 2004-2005, AIP, 2006, ITA, 2017
!  Adapted for use in Phantom by D. Price, MoCA, 2011
!
!  Data for molecular cooling rates (H2, CO)
!
!  1) H2 cooling function data: based on data made available by
!  J. Le Bourlot, G. Pineau des Forets and  D. R. Flower
!  (see Le Bourlot et al, 1999, MNRAS, 305, 802; and also
!  http://ccp7.dur.ac.uk/cooling_by_h2/).
!
!  The LTE rate is in units of erg s^-1 molecule^-1; the low density
!  rates, on the other hand, are written in terms of erg s^-1 cm^3.
!
!  Data in the tables is for log(T) = 2.0 -> 4.0, at intervals of 0.05 dex
!
!  2) CO cooling function data: based on the LVG tabulated rates given in
!  Neufeld & Kaufman (1993, ApJ, 418, 263) and Neufeld, Lepp & Melnick
!  (1995, ApJS, 100, 132). Extended from 10 K to 5 K by
!  Glover & Clark (2012, MNRAS, 421, 116)
!
!  REFERENCES: None
!
!  OWNER: Simon Glover
!
!  $Id$
!
!  RUNTIME PARAMETERS: None
!
!  DEPENDENCIES: None
!+
!--------------------------------------------------------------------------
module mol_data
 implicit none
 integer, parameter :: nh2data = 41
 real :: h2_lte(nh2data), h2_h_rate(nh2data), h2_h2_rate(nh2data), h2_temp(nh2data)
!
! Low density limit -- almost pure H2 -- H/H2 = 1e-8
!
 data h2_h2_rate /-27.604, -27.340, -27.082, -26.856, -26.639, &
                  -26.440, -26.254, -26.078, -25.915, -25.756, &
                  -25.610, -25.466, -25.330, -25.195, -25.065, &
                  -24.937, -24.812, -24.689, -24.569, -24.453, &
                  -24.338, -24.230, -24.124, -24.022, -23.923, &
                  -23.828, -23.735, -23.645, -23.559, -23.475, &
                  -23.395, -23.316, -23.243, -23.171, -23.103, &
                  -23.038, -22.976, -22.918, -22.861, -22.809, &
                  -22.758/
!
! Low density limit -- almost pure H -- H/H2 = 1e6
!
 data h2_h_rate /-28.151, -27.865, -27.593, -27.342, -27.107, &
                 -26.882, -26.669, -26.467, -26.272, -26.085, &
                 -25.905, -25.730, -25.561, -25.395, -25.235, &
                 -25.078, -24.923, -24.772, -24.624, -24.478, &
                 -24.334, -24.192, -24.050, -23.910, -23.772, &
                 -23.634, -23.497, -23.359, -23.222, -23.086, &
                 -22.952, -22.820, -22.691, -22.565, -22.446, &
                 -22.332, -22.225, -22.123, -22.029, -21.943, &
                 -21.943/
!
! LTE rate -- independent of H2/H ratio
!
 data h2_lte /-25.440, -25.107, -24.792, -24.503, -24.239, -23.995, &
              -23.766, -23.550, -23.341, -23.136, -22.933, -22.731, &
              -22.529, -22.330, -22.134, -21.940, -21.748, -21.555, &
              -21.350, -21.122, -20.863, -20.575, -20.282, -20.008, &
              -19.764, -19.552, -19.365, -19.201, -19.056, -18.927, &
              -18.813, -18.712, -18.624, -18.549, -18.484, -18.429, &
              -18.382, -18.341, -18.307, -18.278, -18.253/
!
! CO optically thick rotational cooling
!
 integer, parameter :: nco_temp   = 12
 integer, parameter :: nco_column = 10
 integer, parameter :: nco_data   = 120

 real :: co_temp(nco_temp), co_column(nco_column), co_data_L0(nco_temp)
 real :: co_data_LTE(nco_data), co_data_n05(nco_data), co_data_alp(nco_data)

 data co_temp /5., 10., 20., 30., 50., 80., 100., 300., 600., 1000., 1500., 2000./

 data co_column /14.5, 15.0, 15.5, 16.0, 16.5, 17.0, 17.5, 18.0, 18.5, 19.0/

 data co_data_L0 /25.29, 24.96, 24.56, 24.36, 24.12, 23.88,23.88, &
                  23.40, 23.07, 22.81, 22.61, 22.47/

 data co_data_LTE / 21.93, 21.15, 20.39, 19.97, 19.47, 19.02, &
                    18.81, 17.82, 17.23, 16.82, 16.52, 16.33, &
                    22.05, 21.25, 20.45, 20.02, 19.50, 19.04, &
                    18.83, 17.83, 17.24, 16.82, 16.52, 16.33, &
                    22.27, 21.45, 20.58, 20.12, 19.57, 19.09, &
                    18.87, 17.84, 17.24, 16.83, 16.52, 16.33, &
                    22.59, 21.73, 20.81, 20.31, 19.71, 19.20, &
                    18.96, 17.88, 17.26, 16.84, 16.53, 16.33, &
                    22.99, 22.08, 21.11, 20.58, 19.95, 19.39, &
                    19.14, 17.98, 17.32, 16.88, 16.56, 16.35, &
                    23.41, 22.47, 21.46, 20.91, 20.25, 19.67, &
                    19.40, 18.15, 17.44, 16.96, 16.62, 16.40, &
                    23.86, 22.89, 21.85, 21.28, 20.60, 19.99, &
                    19.71, 18.41, 17.65, 17.13, 16.76, 16.52, &
                    24.33, 23.32, 22.25, 21.67, 20.97, 20.35, &
                    20.07, 18.72, 17.93, 17.38, 16.98, 16.72, &
                    24.80, 23.76, 22.68, 22.08, 21.37, 20.74, &
                    20.45, 19.07, 18.26, 17.69, 17.27, 17.00, &
                    25.27, 24.21, 23.11, 22.51, 21.78, 21.14, &
                    20.85, 19.45, 18.62, 18.03, 17.61, 17.33/

 data co_data_n05 / 3.11, 3.31, 3.72, 3.96, 4.24, 4.39, &
                    4.42, 4.95, 5.24, 5.43, 5.57, 5.68, &
                    2.96, 3.11, 3.59, 3.87, 4.17, 4.35, &
                    4.38, 4.93, 5.23, 5.42, 5.57, 5.68, &
                    2.69, 2.80, 3.34, 3.64, 4.01, 4.23, &
                    4.24, 4.88, 5.20, 5.42, 5.56, 5.68, &
                    2.29, 2.37, 2.95, 3.31, 3.73, 3.99, &
                    4.01, 4.75, 5.13, 5.36, 5.54, 5.65, &
                    1.83, 1.90, 2.50, 2.87, 3.33, 3.61, &
                    3.64, 4.50, 4.95, 5.24, 5.44, 5.58, &
                    1.33, 1.40, 2.02, 2.40, 2.86, 3.17, &
                    3.21, 4.12, 4.65, 5.00, 5.25, 5.41, &
                    0.84, 0.90, 1.52, 1.90, 2.38, 2.69, &
                    2.72, 3.67, 4.25, 4.63, 4.92, 5.13, &
                    0.35, 0.40, 1.02, 1.41, 1.89, 2.19, &
                    2.22, 3.20, 3.77, 4.18, 4.51, 4.73, &
                    -0.15, -0.09, 0.52, 0.91, 1.39, 1.69, &
                    1.73, 2.69, 3.29, 3.70, 4.03, 4.26, &
                    -0.65, -0.59, 0.03, 0.41, 0.88, 1.19, &
                    1.23, 2.20, 2.79, 3.20, 3.54, 3.78/

 data co_data_alp / 0.46, 0.37, 0.41, 0.42, 0.41, 0.38, &
                    0.38, 0.38, 0.38, 0.37, 0.36, 0.35, &
                    0.45, 0.38, 0.42, 0.44, 0.42, 0.39, &
                    0.37, 0.37, 0.37, 0.37, 0.36, 0.35, &
                    0.47, 0.38, 0.43, 0.44, 0.43, 0.40, &
                    0.36, 0.36, 0.36, 0.36, 0.35, 0.34, &
                    0.51, 0.36, 0.41, 0.43, 0.43, 0.40, &
                    0.36, 0.35, 0.35, 0.35, 0.34, 0.33, &
                    0.54, 0.34, 0.37, 0.39, 0.39, 0.39, &
                    0.38, 0.35, 0.34, 0.34, 0.33, 0.32, &
                    0.58, 0.31, 0.33, 0.35, 0.35, 0.35, &
                    0.41, 0.37, 0.35, 0.33, 0.32, 0.31, &
                    0.62, 0.28, 0.31, 0.32, 0.32, 0.31, &
                    0.44, 0.40, 0.37, 0.35, 0.32, 0.31, &
                    0.64, 0.26, 0.28, 0.29, 0.28, 0.28, &
                    0.47, 0.43, 0.40, 0.38, 0.35, 0.33, &
                    0.66, 0.25, 0.26, 0.26, 0.26, 0.26, &
                    0.49, 0.46, 0.43, 0.41, 0.38, 0.36, &
                    0.68, 0.23, 0.25, 0.25, 0.24, 0.25, &
                    0.51, 0.48, 0.46, 0.44, 0.41, 0.39/

end module mol_data
