!--------------------------------------------------------------------------!
! The Phantom Smoothed Particle Hydrodynamics code, by Daniel Price et al. !
! Copyright (c) 2007-2021 The Authors (see AUTHORS)                        !
! See LICENCE file for usage and distribution conditions                   !
! http://phantomsph.bitbucket.io/                                          !
!--------------------------------------------------------------------------!
module memory
!
! None
!
! :References: None
!
! :Owner: Daniel Price
!
! :Runtime parameters: None
!
! :Dependencies: allocutils, dim, io, linklist, part, photoevap
!
 implicit none

contains

 !
 !--Allocate all allocatable arrays: mostly part arrays, and tree structures
 !
subroutine allocate_memory(n, part_only)
 use io, only:iprint,warning,nprocs,id,master
 use dim, only:update_max_sizes,maxp
 use allocutils, only:nbytes_allocated,bytes2human
 use part, only:allocate_part
 use linklist, only:allocate_linklist,ifirstincell
#ifdef PHOTO
 use photoevap, only:allocate_photoevap
#endif

 integer,           intent(in) :: n
 logical, optional, intent(in) :: part_only

 logical :: part_only_
 character(len=11) :: sizestring

 if (present(part_only)) then
    part_only_ = part_only
 else
    part_only_ = .false.
 endif
 if (nbytes_allocated > 0.0 .and. n <= maxp) then
    !
    ! just silently skip if arrays are already large enough
    ! but make sure additional arrays are allocated
    ! (this catches the case where first call was made with part_only=.true.)
    !
    if (.not.part_only_ .and. .not. allocated(ifirstincell)) then
       !write(iprint, '(a)') '--> ALLOCATING KDTREE ARRAYS' ! no need to broadcast this
       call allocate_linklist()
    endif
    ! skip remaining memory allocation (arrays already big enough)
    return
 endif
 call update_max_sizes(n)

 if (nprocs == 1) then
    write(iprint, *)
    if (part_only_) then
       write(iprint, '(a)') '--> ALLOCATING PART ARRAYS'
    else
       write(iprint, '(a)') '--> ALLOCATING ALL ARRAYS'
    endif
 endif

 if (nbytes_allocated > 0.0) then
    call warning('memory', 'Attempting to allocate memory, but memory is already allocated. &
    & Deallocating and then allocating again.')
    call deallocate_memory(part_only=part_only_)
    call update_max_sizes(n)
 endif

 call allocate_part
 if (.not. part_only_) then
    call allocate_linklist
#ifdef PHOTO
    call allocate_photoevap
#endif
 endif

 call bytes2human(nbytes_allocated, sizestring)
 if (nprocs == 1) then
    write(iprint, '(a)') '------------------------------------------------------------'
    write(iprint, *) 'Total memory allocated to arrays: ', sizestring,' n = ',n
    write(iprint, '(a)') '------------------------------------------------------------'
 else
    write(iprint, *) id, 'allocated ', sizestring
 endif

end subroutine allocate_memory

subroutine deallocate_memory(part_only)
 use dim, only:update_max_sizes
 use part, only:deallocate_part
 use linklist, only:deallocate_linklist
#ifdef PHOTO
 use photoevap, only:deallocate_photoevap
#endif
 use allocutils, only:nbytes_allocated

 logical, optional, intent(in) :: part_only
 logical :: part_only_

 if (present(part_only)) then
    part_only_ = part_only
 else
    part_only_ = .false.
 endif

 call deallocate_part
 if (.not. part_only_) then
    call deallocate_linklist
#ifdef PHOTO
    call deallocate_photoevap
#endif
 endif

 nbytes_allocated = 0
 call update_max_sizes(0)

end subroutine deallocate_memory

end module memory
